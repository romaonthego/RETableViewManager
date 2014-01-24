//
// RETableViewSection.m
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

#import "RETableViewSection.h"
#import "RETableViewManager.h"
#import "NSString+RETableViewManagerAdditions.h"
#import <float.h>

CGFloat const RETableViewSectionHeaderHeightAutomatic = DBL_MAX;
CGFloat const RETableViewSectionFooterHeightAutomatic = DBL_MAX;

@interface RETableViewSection ()

@property (strong, readwrite, nonatomic) NSMutableArray *mutableItems;

@end

@implementation RETableViewSection

#pragma mark -
#pragma mark Creating and Initializing Sections

+ (instancetype)section
{
    return [[self alloc] init];
}

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle
{
    return [[self alloc ] initWithHeaderTitle:headerTitle];
}

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    return [[self alloc] initWithHeaderTitle:headerTitle footerTitle:footerTitle];
}

+ (instancetype)sectionWithHeaderView:(UIView *)headerView
{
    return [[self alloc] initWithHeaderView:headerView footerView:nil];
}

+ (instancetype)sectionWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView
{
    return [[self alloc] initWithHeaderView:headerView footerView:footerView];
}

- (id)init
{
    self = [super init];
    if (!self)
        return nil;
    
    _mutableItems = [[NSMutableArray alloc] init];
    _headerHeight = RETableViewSectionHeaderHeightAutomatic;
    _footerHeight = RETableViewSectionFooterHeightAutomatic;
    
    return self;
}

- (id)initWithHeaderTitle:(NSString *)headerTitle
{
    return [self initWithHeaderTitle:headerTitle footerTitle:nil];
}

- (id)initWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    self = [self init];
    if (!self)
        return nil;
    
    self.headerTitle = headerTitle;
    self.footerTitle = footerTitle;
    
    return self;
}

- (id)initWithHeaderView:(UIView *)headerView
{
    return [self initWithHeaderView:headerView footerView:nil];
}

- (id)initWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView
{
    self = [self init];
    if (!self)
        return nil;
    
    self.headerView = headerView;
    self.footerView = footerView;
    
    return self;
}

#pragma mark -
#pragma mark Styling

- (RETableViewCellStyle *)style
{
    return _style ? _style : self.tableViewManager.style;
}

#pragma mark -
#pragma mark Reading information

- (NSUInteger)index
{
    RETableViewManager *tableViewManager = self.tableViewManager;
    return [tableViewManager.sections indexOfObject:self];
}

- (CGFloat)maximumTitleWidthWithFont:(UIFont *)font
{
    CGFloat width = 0;
    for (RETableViewItem *item in self.mutableItems) {
        if ([item isKindOfClass:[RETextItem class]] || [item isKindOfClass:[REDateTimeItem class]] || [item isKindOfClass:[RERadioItem class]] || [item isKindOfClass:[REMultipleChoiceItem class]] || [item isKindOfClass:[RENumberItem class]]) {
            CGSize size = [item.title re_sizeWithFont:font];
            width = MAX(width, size.width);
        }
    }
    return width + 5.0;
}

#pragma mark -
#pragma mark Managing items

- (NSArray *)items
{
    return self.mutableItems;
}

- (void)addItem:(id)item
{
    if ([item isKindOfClass:[RETableViewItem class]])
        ((RETableViewItem *)item).section = self;
    
    [self.mutableItems addObject:item];
}

- (void)addItemsFromArray:(NSArray *)array
{
    for (RETableViewItem *item in array)
        if ([item isKindOfClass:[RETableViewItem class]])
            ((RETableViewItem *)item).section = self;
    
    [self.mutableItems addObjectsFromArray:array];
}

- (void)insertItem:(id)item atIndex:(NSUInteger)index
{
    if ([item isKindOfClass:[RETableViewItem class]])
        ((RETableViewItem *)item).section = self;
    
    [self.mutableItems insertObject:item atIndex:index];
}

- (void)insertItems:(NSArray *)items atIndexes:(NSIndexSet *)indexes
{
    for (RETableViewItem *item in items)
        if ([item isKindOfClass:[RETableViewItem class]])
            ((RETableViewItem *)item).section = self;
    
    [self.mutableItems insertObjects:items atIndexes:indexes];
}

- (void)removeItem:(id)item inRange:(NSRange)range
{
    [self.mutableItems removeObject:item inRange:range];
}

- (void)removeLastItem
{
    [self.mutableItems removeLastObject];
}

- (void)removeItemAtIndex:(NSUInteger)index
{
    [self.mutableItems removeObjectAtIndex:index];
}

- (void)removeItem:(id)item
{
    [self.mutableItems removeObject:item];
}

- (void)removeAllItems
{
    [self.mutableItems removeAllObjects];
}

- (void)removeItemIdenticalTo:(id)item inRange:(NSRange)range
{
    [self.mutableItems removeObjectIdenticalTo:item inRange:range];
}

- (void)removeItemIdenticalTo:(id)item
{
    [self.mutableItems removeObjectIdenticalTo:item];
}

- (void)removeItemsInArray:(NSArray *)otherArray
{
    [self.mutableItems removeObjectsInArray:otherArray];
}

- (void)removeItemsInRange:(NSRange)range
{
    [self.mutableItems removeObjectsInRange:range];
}

- (void)removeItemsAtIndexes:(NSIndexSet *)indexes
{
    [self.mutableItems removeObjectsAtIndexes:indexes];
}

- (void)replaceItemAtIndex:(NSUInteger)index withItem:(id)item
{
    if ([item isKindOfClass:[RETableViewItem class]])
        ((RETableViewItem *)item).section = self;
    
    [self.mutableItems replaceObjectAtIndex:index withObject:item];
}

- (void)replaceItemsWithItemsFromArray:(NSArray *)otherArray
{
    [self removeAllItems];
    [self addItemsFromArray:otherArray];
}

- (void)replaceItemsInRange:(NSRange)range withItemsFromArray:(NSArray *)otherArray range:(NSRange)otherRange
{
    for (RETableViewItem *item in otherArray)
        if ([item isKindOfClass:[RETableViewItem class]])
            ((RETableViewItem *)item).section = self;
    
    [self.mutableItems replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
}

- (void)replaceItemsInRange:(NSRange)range withItemsFromArray:(NSArray *)otherArray
{
    for (RETableViewItem *item in otherArray)
        if ([item isKindOfClass:[RETableViewItem class]])
            ((RETableViewItem *)item).section = self;
    
    [self.mutableItems replaceObjectsInRange:range withObjectsFromArray:otherArray];
}

- (void)replaceItemsAtIndexes:(NSIndexSet *)indexes withItems:(NSArray *)items
{
    for (RETableViewItem *item in items)
        if ([item isKindOfClass:[RETableViewItem class]])
            ((RETableViewItem *)item).section = self;
    
    [self.mutableItems replaceObjectsAtIndexes:indexes withObjects:items];
}

- (void)exchangeItemAtIndex:(NSUInteger)idx1 withItemAtIndex:(NSUInteger)idx2
{
    [self.mutableItems exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

- (void)sortItemsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context
{
    [self.mutableItems sortUsingFunction:compare context:context];
}

- (void)sortItemsUsingSelector:(SEL)comparator
{
    [self.mutableItems sortUsingSelector:comparator];
}

#pragma mark -
#pragma mark Manipulating table view section

- (void)reloadSectionWithAnimation:(UITableViewRowAnimation)animation
{
    [self.tableViewManager.tableView reloadSections:[NSIndexSet indexSetWithIndex:self.index] withRowAnimation:animation];
}

#pragma mark -
#pragma mark Checking for errors

- (NSArray *)errors
{
    NSMutableArray *errors;
    for (RETableViewItem *item in self.mutableItems) {
        if ([item respondsToSelector:@selector(errors)]) {
            NSArray *itemErrors = item.errors;
            if (itemErrors) {
                if (!errors) {
                    errors = [[NSMutableArray alloc] init];
                }
                if (itemErrors.count > 0)
                    [errors addObject:itemErrors[0]];
            }
        }
    }
    return errors;
}

@end
