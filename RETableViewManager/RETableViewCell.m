//
// RETableViewCell.m
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

#import "RETableViewCell.h"
#import "RETableViewManager.h"

@interface RETableViewCell ()

@property (assign, readwrite, nonatomic) BOOL loaded;
@property (strong, readwrite, nonatomic) UIImageView *backgroundImageView;
@property (strong, readwrite, nonatomic) UIImageView *selectedBackgroundImageView;

@end

@implementation RETableViewCell

+ (BOOL)canFocusWithItem:(RETableViewItem *)item
{
    return NO;
}

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    if ([item isKindOfClass:[RETableViewItem class]] && item.cellHeight > 0)
        return item.cellHeight;
    
    if ([item isKindOfClass:[RETableViewItem class]] && item.cellHeight == 0)
        return item.section.style.cellHeight;
    
    return tableViewManager.style.cellHeight;
}

#pragma mark - UI

- (void)addBackgroundImage
{
    self.tableViewManager.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.backgroundView.bounds.size.width, self.backgroundView.bounds.size.height + 1)];
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.backgroundView addSubview:self.backgroundImageView];
}

- (void)addSelectedBackgroundImage
{
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.selectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.selectedBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.selectedBackgroundView.bounds.size.width, self.selectedBackgroundView.bounds.size.height + 1)];
    self.selectedBackgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.selectedBackgroundView addSubview:self.selectedBackgroundImageView];
}

#pragma mark -
#pragma mark Cell life cycle

- (void)cellDidLoad
{
    self.loaded = YES;
    self.actionBar = [[REActionBar alloc] initWithDelegate:self];
    self.selectionStyle = self.tableViewManager.style.defaultCellSelectionStyle;
    
    if ([self.tableViewManager.style hasCustomBackgroundImage]) {
        [self addBackgroundImage];
    }
    
    if ([self.tableViewManager.style hasCustomSelectedBackgroundImage]) {
        [self addSelectedBackgroundImage];
    }
}

- (void)cellWillAppear
{
    [self updateActionBarNavigationControl];
    self.selectionStyle = self.section.style.defaultCellSelectionStyle;
    
    if ([self.item isKindOfClass:[NSString class]]) {
        self.textLabel.text = (NSString *)self.item;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        RETableViewItem *item = (RETableViewItem *)self.item;
        self.textLabel.text = item.title;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.accessoryType = item.accessoryType;
        self.accessoryView = item.accessoryView;
        self.textLabel.textAlignment = item.textAlignment;
        if (self.selectionStyle != UITableViewCellSelectionStyleNone)
            self.selectionStyle = item.selectionStyle;
        self.imageView.image = item.image;
        self.imageView.highlightedImage = item.highlightedImage;
    }
    if (self.textLabel.text.length == 0)
        self.textLabel.text = @" ";
}

- (void)cellDidDisappear
{

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Set content frame
    //
    CGRect contentFrame = self.contentView.frame;
    contentFrame.origin.x = contentFrame.origin.x + self.section.style.contentViewMargin;
    contentFrame.size.width = contentFrame.size.width - self.section.style.contentViewMargin * 2;
    self.contentView.frame = contentFrame;
    
    // iOS 7 textLabel margin fix
    //
    if (self.section.style.contentViewMargin > 0) {
        if (self.imageView.image) {
            self.imageView.frame = CGRectMake(self.section.style.contentViewMargin, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
            self.textLabel.frame = CGRectMake(self.section.style.contentViewMargin + self.imageView.frame.size.width + 15.0, self.textLabel.frame.origin.y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
        } else {
            self.textLabel.frame = CGRectMake(self.section.style.contentViewMargin, self.textLabel.frame.origin.y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
        }
    }
    
    if ([self.section.style hasCustomBackgroundImage]) {
        self.backgroundColor = [UIColor clearColor];
        if (!self.backgroundImageView) {
            [self addBackgroundImage];
        }
        self.backgroundImageView.image = [self.section.style backgroundImageForCellType:self.type];
    }
    
    if ([self.section.style hasCustomSelectedBackgroundImage]) {
        if (!self.selectedBackgroundImageView) {
            [self addSelectedBackgroundImage];
        }
        self.selectedBackgroundImageView.image = [self.section.style selectedBackgroundImageForCellType:self.type];
    }
    
    // Set background frame
    //
    CGRect backgroundFrame = self.backgroundImageView.frame;
    backgroundFrame.origin.x = self.section.style.backgroundImageMargin;
    backgroundFrame.size.width = self.backgroundView.frame.size.width - self.section.style.backgroundImageMargin * 2;
    self.backgroundImageView.frame = backgroundFrame;
    self.selectedBackgroundImageView.frame = backgroundFrame;

}

- (void)layoutDetailView:(UIView *)view minimumWidth:(CGFloat)minimumWidth
{
    CGFloat cellOffset = 10.0;
    CGFloat fieldOffset = 10.0;
    
    if (REUIKitIsFlatMode() && self.section.style.contentViewMargin <= 0)
        cellOffset += 5.0;
    
    UIFont *font = self.textLabel.font;
    
    CGRect frame = CGRectMake(0, self.textLabel.frame.origin.y, 0, self.textLabel.frame.size.height);
    if (self.item.title.length > 0) {
        frame.origin.x = [self.section maximumTitleWidthWithFont:font] + cellOffset + fieldOffset;
    } else {
        frame.origin.x = cellOffset;
    }
    frame.size.width = self.contentView.frame.size.width - frame.origin.x - cellOffset;
    if (frame.size.width < minimumWidth) {
        CGFloat diff = minimumWidth - frame.size.width;
        frame.origin.x = frame.origin.x - diff;
        frame.size.width = minimumWidth;
    }
    
    view.frame = frame;
}

- (RETableViewCellType)type
{
    if (self.rowIndex == 0 && self.section.items.count == 1)
        return RETableViewCellTypeSingle;
    
    if (self.rowIndex == 0 && self.section.items.count > 1)
        return RETableViewCellTypeFirst;
    
    if (self.rowIndex > 0 && self.rowIndex < self.section.items.count - 1 && self.section.items.count > 2)
        return RETableViewCellTypeMiddle;
    
    if (self.rowIndex == self.section.items.count - 1 && self.section.items.count > 1)
        return RETableViewCellTypeLast;
    
    return RETableViewCellTypeAny;
}

- (void)updateActionBarNavigationControl
{
    [self.actionBar.navigationControl setEnabled:[self indexPathForPreviousResponder] != nil forSegmentAtIndex:0];
    [self.actionBar.navigationControl setEnabled:[self indexPathForNextResponder] != nil forSegmentAtIndex:1];
}

- (UIResponder *)responder
{
    return nil;
}

- (NSIndexPath *)indexPathForPreviousResponderInSectionIndex:(NSUInteger)sectionIndex
{
    RETableViewSection *section = [self.tableViewManager.sections objectAtIndex:sectionIndex];
    NSUInteger indexInSection =  [section isEqual:self.section] ? [section.items indexOfObject:self.item] : section.items.count;
    for (NSInteger i = indexInSection - 1; i >= 0; i--) {
        RETableViewItem *item = [section.items objectAtIndex:i];
        if ([item isKindOfClass:[RETableViewItem class]]) {
            Class class = [self.tableViewManager classForCellAtIndexPath:item.indexPath];
            if ([class canFocusWithItem:item])
                return [NSIndexPath indexPathForRow:i inSection:sectionIndex];
        }
    }
    return nil;
}

- (NSIndexPath *)indexPathForPreviousResponder
{
    for (NSInteger i = self.sectionIndex; i >= 0; i--) {
        NSIndexPath *indexPath = [self indexPathForPreviousResponderInSectionIndex:i];
        if (indexPath)
            return indexPath;
    }
    return nil;
}

- (NSIndexPath *)indexPathForNextResponderInSectionIndex:(NSUInteger)sectionIndex
{
    RETableViewSection *section = [self.tableViewManager.sections objectAtIndex:sectionIndex];
    NSUInteger indexInSection =  [section isEqual:self.section] ? [section.items indexOfObject:self.item] : -1;
    for (NSInteger i = indexInSection + 1; i < section.items.count; i++) {
        RETableViewItem *item = [section.items objectAtIndex:i];
        if ([item isKindOfClass:[RETableViewItem class]]) {
            Class class = [self.tableViewManager classForCellAtIndexPath:item.indexPath];
            if ([class canFocusWithItem:item])
                return [NSIndexPath indexPathForRow:i inSection:sectionIndex];
        }
    }
    return nil;
}

- (NSIndexPath *)indexPathForNextResponder
{
    for (NSInteger i = self.sectionIndex; i < self.tableViewManager.sections.count; i++) {
        NSIndexPath *indexPath = [self indexPathForNextResponderInSectionIndex:i];
        if (indexPath)
            return indexPath;
    }
    
    return nil;
}

#pragma mark - 
#pragma mark REActionBar delegate

- (void)actionBar:(REActionBar *)actionBar navigationControlValueChanged:(UISegmentedControl *)navigationControl
{
    NSIndexPath *indexPath = navigationControl.selectedSegmentIndex == 0 ? [self indexPathForPreviousResponder] : [self indexPathForNextResponder];
    if (indexPath) {
        RETableViewCell *cell = (RETableViewCell *)[self.parentTableView cellForRowAtIndexPath:indexPath];
        if (!cell)
            [self.parentTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        cell = (RETableViewCell *)[self.parentTableView cellForRowAtIndexPath:indexPath];
        [cell.responder becomeFirstResponder];
    }
    if (self.item.actionBarNavButtonTapHandler)
        self.item.actionBarNavButtonTapHandler(self.item);
}

- (void)actionBar:(REActionBar *)actionBar doneButtonPressed:(UIBarButtonItem *)doneButtonItem
{
    if (self.item.actionBarDoneButtonTapHandler)
        self.item.actionBarDoneButtonTapHandler(self.item);

    [self endEditing:YES];
}

@end
