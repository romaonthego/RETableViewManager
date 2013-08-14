//
// RETableViewManager.m
// RETableViewManager
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "RETableViewManager.h"

NSUInteger REDeviceSystemMajorVersion() {
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}

BOOL REDeviceIsUIKit7() {
#ifdef __IPHONE_7_0
    if (REDeviceSystemMajorVersion() >= 7.0) {
        return YES;
    }
#endif
    return NO;
}

@implementation RETableViewManager

- (id)init
{
    @throw [NSException exceptionWithName:NSGenericException reason:@"init not supported, use initWithTableView: instead." userInfo:nil];
    return nil;
}

- (id)initWithTableView:(UITableView *)tableView delegate:(id<RETableViewManagerDelegate>)delegate
{
    self = [self initWithTableView:tableView];
    if (!self)
        return nil;
    
    self.delegate = delegate;
    
    return self;
}

- (id)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    if (!self)
        return nil;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    self.tableView = tableView;

    _sections = [[NSMutableArray alloc] init];
    _registeredClasses = [[NSMutableDictionary alloc] init];
    _style = [[RETableViewCellStyle alloc] init];
    
    [self registerDefaultClasses];
    
    return self;
}

- (void)registerDefaultClasses
{
    self[@"__NSCFConstantString"] = @"RETableViewCell";
    self[@"__NSCFString"] = @"RETableViewCell";
    self[@"NSString"] = @"RETableViewCell";
    self[@"RETableViewItem"] = @"RETableViewCell";
    self[@"RERadioItem"] = @"RETableViewOptionCell";
    self[@"REBoolItem"] = @"RETableViewBoolCell";
    self[@"RETextItem"] = @"RETableViewTextCell";
    self[@"RELongTextItem"] = @"RETableViewLongTextCell";
    self[@"RENumberItem"] = @"RETableViewNumberCell";
    self[@"REFloatItem"] = @"RETableViewFloatCell";
    self[@"REDateTimeItem"] = @"RETableViewDateTimeCell";
    self[@"RECreditCardItem"] = @"RETableViewCreditCardCell";
    self[@"REMultipleChoiceItem"] = @"RETableViewOptionCell";
}

- (void)registerClass:(NSString *)objectClass forCellWithReuseIdentifier:(NSString *)identifier
{
    NSAssert(NSClassFromString(objectClass), ([NSString stringWithFormat:@"Item class '%@' does not exist.", identifier]));
    NSAssert(NSClassFromString(identifier), ([NSString stringWithFormat:@"Cell class '%@' does not exist.", identifier]));
    [_registeredClasses setObject:identifier forKey:objectClass];
}

- (id)objectAtKeyedSubscript:(id <NSCopying>)key
{
    return [_registeredClasses objectForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    [self registerClass:(NSString *)key forCellWithReuseIdentifier:obj];
}

- (Class)classForCellAtIndexPath:(NSIndexPath *)indexPath
{
    RETableViewSection *section = [_sections objectAtIndex:indexPath.section];
    NSObject *item = [section.items objectAtIndex:indexPath.row];
    Class cellClass;
    for (NSString *className in _registeredClasses) {
        NSString *itemClass = NSStringFromClass([item class]);
        if ([itemClass isEqualToString:className]) {
            cellClass = NSClassFromString([_registeredClasses objectForKey:className]);
            break;
        }
    }
    return cellClass;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return ((RETableViewSection *)[_sections objectAtIndex:sectionIndex]).items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RETableViewSection *section = [_sections objectAtIndex:indexPath.section];
    RETableViewItem *item = [section.items objectAtIndex:indexPath.row];
    
    UITableViewCellStyle cellStyle = UITableViewCellStyleDefault;
    if ([item isKindOfClass:[RETableViewItem class]])
        cellStyle = ((RETableViewItem *)item).style;
    
    NSString *cellIdentifier = [item respondsToSelector:@selector(cellIdentifier)] && item.cellIdentifier ? item.cellIdentifier : [NSString stringWithFormat:@"RETableViewManager_%@_%i", [item class], cellStyle];
  
    Class cellClass = [self classForCellAtIndexPath:indexPath];
    
    RETableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:cellStyle reuseIdentifier:cellIdentifier];
        cell.tableViewManager = self;
        
        // RETableViewManagerDelegate
        //
        if ([_delegate conformsToProtocol:@protocol(RETableViewManagerDelegate)] && [_delegate respondsToSelector:@selector(tableView:willLoadCell:forRowAtIndexPath:)])
            [_delegate tableView:tableView willLoadCell:cell forRowAtIndexPath:indexPath];
        
        [cell cellDidLoad];
        
        // RETableViewManagerDelegate
        //
        if ([_delegate conformsToProtocol:@protocol(RETableViewManagerDelegate)] && [_delegate respondsToSelector:@selector(tableView:didLoadCell:forRowAtIndexPath:)])
            [_delegate tableView:tableView didLoadCell:cell forRowAtIndexPath:indexPath];
    }
    
    cell.rowIndex = indexPath.row;
    cell.sectionIndex = indexPath.section;
    cell.parentTableView = tableView;
    cell.section = section;
    cell.item = item;
    cell.detailTextLabel.text = nil;
    
    if ([item isKindOfClass:[RETableViewItem class]])
        cell.detailTextLabel.text = ((RETableViewItem *)item).detailLabelText;
    
    [cell cellWillAppear];
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *titles;
    for (RETableViewSection *section in self.sections) {
        if (section.indexTitle) {
            titles = [NSMutableArray array];
            break;
        }
    }
    if (titles) {
        for (RETableViewSection *section in self.sections) {
            [titles addObject:section.indexTitle ? section.indexTitle : @""];
        }
    }
    
    return titles;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)sectionIndex
{
    RETableViewSection *section = [_sections objectAtIndex:sectionIndex];
    return section.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)sectionIndex
{
    RETableViewSection *section = [_sections objectAtIndex:sectionIndex];
    return section.footerTitle;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    RETableViewSection *sourceSection = [_sections objectAtIndex:sourceIndexPath.section];
    RETableViewItem *item = [sourceSection.items objectAtIndex:sourceIndexPath.row];
    [sourceSection removeItemAtIndex:sourceIndexPath.row];
    
    RETableViewSection *destinationSection = [_sections objectAtIndex:destinationIndexPath.section];
    [destinationSection insertItem:item atIndex:destinationIndexPath.row];
    
    if (item.moveCompletionHandler)
        item.moveCompletionHandler(item, sourceIndexPath, destinationIndexPath);
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    RETableViewSection *section = [_sections objectAtIndex:indexPath.section];
    RETableViewItem *item = [section.items objectAtIndex:indexPath.row];
    return item.moveHandler != nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    RETableViewSection *section = [_sections objectAtIndex:indexPath.section];
    RETableViewItem *item = [section.items objectAtIndex:indexPath.row];
    if ([item isKindOfClass:[RETableViewItem class]]) {
        return item.editingStyle != UITableViewCellEditingStyleNone || item.moveHandler;
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        RETableViewSection *section = [_sections objectAtIndex:indexPath.section];
        RETableViewItem *item = [section.items objectAtIndex:indexPath.row];
        if (item.deletionHandlerWithCompletion) {
            item.deletionHandlerWithCompletion(item, ^{
                [section.items removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        } else {
            if (item.deletionHandler)
                item.deletionHandler(item);
            [section.items removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
    
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        RETableViewSection *section = [_sections objectAtIndex:indexPath.section];
        RETableViewItem *item = [section.items objectAtIndex:indexPath.row];
        if (item.insertionHandler)
            item.insertionHandler(item);
    }
}

#pragma mark -
#pragma mark Table view delegate

// Display customization

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)])
        [_delegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)])
        [_delegate tableView:tableView willDisplayHeaderView:view forSection:section];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)])
        [_delegate tableView:tableView willDisplayFooterView:view forSection:section];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ([cell isKindOfClass:[RETableViewCell class]])
        [(RETableViewCell *)cell cellDidDisappear];
    
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)])
        [_delegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)])
        [_delegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)])
        [_delegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
}

// Variable height support

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RETableViewSection *section = [_sections objectAtIndex:indexPath.section];
    id item = [section.items objectAtIndex:indexPath.row];
    
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])
        return [_delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    
    return [[self classForCellAtIndexPath:indexPath] heightWithItem:item tableViewManager:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    RETableViewSection *section = [_sections objectAtIndex:sectionIndex];
    if (section.headerView)
        return section.headerView.frame.size.height;
    
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)])
        return [_delegate tableView:tableView heightForHeaderInSection:sectionIndex];
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectionIndex
{
    RETableViewSection *section = [_sections objectAtIndex:sectionIndex];
    if (section.footerView)
        return section.footerView.frame.size.height;
    
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)])
        return [_delegate tableView:tableView heightForFooterInSection:sectionIndex];
    
    return UITableViewAutomaticDimension;
}

// Section header & footer information. Views are preferred over title should you decide to provide both

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    RETableViewSection *section = [_sections objectAtIndex:sectionIndex];
    
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)])
        return [_delegate tableView:tableView viewForHeaderInSection:sectionIndex];
    
    return section.headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)sectionIndex
{
    RETableViewSection *section = [_sections objectAtIndex:sectionIndex];
    
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)])
        return [_delegate tableView:tableView viewForFooterInSection:sectionIndex];
    
    return section.footerView;
}

// Accessories (disclosures).

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    RETableViewSection *section = [_sections objectAtIndex:indexPath.section];
    id item = [section.items objectAtIndex:indexPath.row];
    if ([item respondsToSelector:@selector(setAccessoryButtonTapHandler:)]) {
        RETableViewItem *actionItem = (RETableViewItem *)item;
        if (actionItem.accessoryButtonTapHandler)
            actionItem.accessoryButtonTapHandler(item);
    }
    
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)])
        [_delegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
}

// Selection

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:shouldHighlightRowAtIndexPath:)])
        return [_delegate tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:didHighlightRowAtIndexPath:)])
        [_delegate tableView:tableView didHighlightRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:didUnhighlightRowAtIndexPath:)])
        [_delegate tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)])
        return [_delegate tableView:tableView willSelectRowAtIndexPath:indexPath];
    
    return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)])
        return [_delegate tableView:tableView willDeselectRowAtIndexPath:indexPath];
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RETableViewSection *section = [_sections objectAtIndex:indexPath.section];
    id item = [section.items objectAtIndex:indexPath.row];
    if ([item respondsToSelector:@selector(setSelectionHandler:)]) {
        RETableViewItem *actionItem = (RETableViewItem *)item;
        if (actionItem.selectionHandler)
            actionItem.selectionHandler(item);
    }
    
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
        [_delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)])
        [_delegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
}

// Editing

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RETableViewSection *section = [_sections objectAtIndex:indexPath.section];
    RETableViewItem *item = [section.items objectAtIndex:indexPath.row];
    
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)])
        return [_delegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    
    return item.editingStyle;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)])
        return [_delegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    
    return NSLocalizedString(@"Delete", @"Delete");
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)])
        return [_delegate tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    
    return YES;
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)])
        [_delegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)])
        [_delegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
}

// Moving/reordering

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    RETableViewSection *sourceSection = [_sections objectAtIndex:sourceIndexPath.section];
    RETableViewItem *item = [sourceSection.items objectAtIndex:sourceIndexPath.row];
    if (item.moveHandler) {
        BOOL allowed = item.moveHandler(item, sourceIndexPath, proposedDestinationIndexPath);
        if (!allowed)
            return sourceIndexPath;
    }
    
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)])
        return [_delegate tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    
    return proposedDestinationIndexPath;
}

// Indentation

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)])
        return [_delegate tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    
    return 0;
}

// Copy/Paste.  All three methods must be implemented by the delegate.

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RETableViewSection *section = [_sections objectAtIndex:indexPath.section];
    id anItem = [section.items objectAtIndex:indexPath.row];
    if ([anItem respondsToSelector:@selector(setCopyHandler:)]) {
        RETableViewItem *item = anItem;
        if (item.copyHandler || item.pasteHandler)
            return YES;
    }
    
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)])
        return [_delegate tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
    
	return NO;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    RETableViewSection *section = [_sections objectAtIndex:indexPath.section];
    id anItem = [section.items objectAtIndex:indexPath.row];
    if ([anItem respondsToSelector:@selector(setCopyHandler:)]) {
        RETableViewItem *item = anItem;
        if (item.copyHandler && action == @selector(copy:))
            return YES;
        
        if (item.pasteHandler && action == @selector(paste:))
            return YES;
        
        if (item.cutHandler && action == @selector(cut:))
            return YES;
    }
    
    // Forward to UITableViewDelegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)])
        return [_delegate tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
	
	return NO;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    RETableViewSection *section = [_sections objectAtIndex:indexPath.section];
    RETableViewItem *item = [section.items objectAtIndex:indexPath.row];
    
	if (action == @selector(copy:)) {
		if (item.copyHandler)
            item.copyHandler(item);
	}
    
    if (action == @selector(paste:)) {
		if (item.pasteHandler)
            item.pasteHandler(item);
	}
    
    if (action == @selector(cut:)) {
		if (item.cutHandler)
            item.cutHandler(item);
	}
    
    // Forward to UITableView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UITableViewDelegate)] && [_delegate respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)])
        [_delegate tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidScroll:)])
        [_delegate scrollViewDidScroll:self.tableView];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidZoom:)])
        [_delegate scrollViewDidZoom:self.tableView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)])
        [_delegate scrollViewWillBeginDragging:self.tableView];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    // Forward to UIScrollView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)])
        [_delegate scrollViewWillEndDragging:self.tableView withVelocity:velocity targetContentOffset:targetContentOffset];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // Forward to UIScrollView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)])
        [_delegate scrollViewDidEndDragging:self.tableView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)])
        [_delegate scrollViewWillBeginDecelerating:self.tableView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)])
        [_delegate scrollViewDidEndDecelerating:self.tableView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)])
        [_delegate scrollViewDidEndScrollingAnimation:self.tableView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(viewForZoomingInScrollView:)])
        return [_delegate viewForZoomingInScrollView:self.tableView];
    
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    // Forward to UIScrollView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)])
        [_delegate scrollViewWillBeginZooming:self.tableView withView:view];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    // Forward to UIScrollView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)])
        [_delegate scrollViewDidEndZooming:self.tableView withView:view atScale:scale];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)])
        return [_delegate scrollViewShouldScrollToTop:self.tableView];
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    // Forward to UIScrollView delegate
    //
    if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)])
        [_delegate scrollViewDidScrollToTop:self.tableView];
}

#pragma mark -
#pragma mark Managing sections

- (void)addSection:(RETableViewSection *)section
{
    section.tableViewManager = self;
    [_sections addObject:section];
}

- (void)addSectionsFromArray:(NSArray *)array
{
    for (RETableViewSection *section in array)
        section.tableViewManager = self;
    [_sections addObjectsFromArray:array];
}

- (void)insertSection:(RETableViewSection *)section atIndex:(NSUInteger)index
{
    section.tableViewManager = self;
    [_sections insertObject:section atIndex:index];
}

- (void)insertSections:(NSArray *)sections atIndexes:(NSIndexSet *)indexes
{
    for (RETableViewSection *section in sections)
        section.tableViewManager = self;
    [_sections insertObjects:sections atIndexes:indexes];
}

- (void)removeSection:(RETableViewSection *)section
{
    [_sections removeObject:section];
}

- (void)removeAllSections
{
    [_sections removeAllObjects];
}

- (void)removeSectionIdenticalTo:(RETableViewSection *)section inRange:(NSRange)range
{
    [_sections removeObjectIdenticalTo:section inRange:range];
}

- (void)removeSectionIdenticalTo:(RETableViewSection *)section
{
    [_sections removeObjectIdenticalTo:section];
}

- (void)removeSectionsInArray:(NSArray *)otherArray
{
    [_sections removeObjectsInArray:otherArray];
}

- (void)removeSectionsInRange:(NSRange)range
{
    [_sections removeObjectsInRange:range];
}

- (void)removeSection:(RETableViewSection *)section inRange:(NSRange)range
{
    [_sections removeObject:section inRange:range];
}

- (void)removeLastSection
{
    [_sections removeLastObject];
}

- (void)removeSectionAtIndex:(NSUInteger)index
{
    [_sections removeObjectAtIndex:index];
}

- (void)removeSectionsAtIndexes:(NSIndexSet *)indexes
{
    [_sections removeObjectsAtIndexes:indexes];
}

- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(RETableViewSection *)section
{
    section.tableViewManager = self;
    [_sections replaceObjectAtIndex:index withObject:section];
}

- (void)replaceSectionsWithSectionsFromArray:(NSArray *)otherArray
{
    [self removeAllSections];
    [self addSectionsFromArray:otherArray];
}

- (void)replaceSectionsAtIndexes:(NSIndexSet *)indexes withSections:(NSArray *)sections
{
    for (RETableViewSection *section in sections)
        section.tableViewManager = self;
    [_sections replaceObjectsAtIndexes:indexes withObjects:sections];
}

- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray *)otherArray range:(NSRange)otherRange
{
    for (RETableViewSection *section in otherArray)
        section.tableViewManager = self;
    [_sections replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
}

- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray *)otherArray
{
    [_sections replaceObjectsInRange:range withObjectsFromArray:otherArray];
}

- (void)exchangeSectionAtIndex:(NSUInteger)idx1 withSectionAtIndex:(NSUInteger)idx2
{
    [_sections exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

- (void)sortSectionsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context
{
    [_sections sortUsingFunction:compare context:context];
}

- (void)sortSectionsUsingSelector:(SEL)comparator
{
    [_sections sortUsingSelector:comparator];
}

@end
