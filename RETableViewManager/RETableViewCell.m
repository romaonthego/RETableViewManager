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

@implementation RETableViewCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return tableViewManager.style.cellHeight;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

#pragma mark -
#pragma mark Cell life cycle

- (void)cellDidLoad
{
    self.actionBar = [[REActionBar alloc] initWithDelegate:self];
    
    if ([self.tableViewManager.style hasCustomBackgroundImage]) {
        self.backgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backgroundImageView = [[UIImageView alloc] init];
        [self.backgroundView addSubview:_backgroundImageView];
    }
}

- (void)cellWillAppear
{
    [self updateActionBarNavigationControl];
    
    if ([self.item isKindOfClass:[NSString class]]) {
        self.textLabel.text = (NSString *)self.item;
    } else {
        RETableViewItem *item = (RETableViewItem *)self.item;
        self.textLabel.text = item.title;
        self.accessoryType = item.accessoryType;
        self.accessoryView = item.accessoryView;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([self.tableViewManager.style hasCustomBackgroundImage]) {
        if (self.row == 0 && self.section.items.count == 1)
            _backgroundImageView.image = [self.tableViewManager.style backgroundImageForCellType:RETableViewCellSingle];
        
        if (self.row == 0 && self.section.items.count > 1)
            _backgroundImageView.image = [self.tableViewManager.style backgroundImageForCellType:RETableViewCellFirst];
        
        if (self.row > 0 && self.row < self.section.items.count - 1 && self.section.items.count > 2)
            _backgroundImageView.image = [self.tableViewManager.style backgroundImageForCellType:RETableViewCellMiddle];
        
        if (self.row == self.section.items.count - 1 && self.section.items.count > 1)
            _backgroundImageView.image = [self.tableViewManager.style backgroundImageForCellType:RETableViewCellLast];
        
        _backgroundImageView.frame = CGRectMake(0, 0, _backgroundImageView.image.size.width, _backgroundImageView.image.size.height);
    }
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
        if ([item isKindOfClass:[RETableViewItem class]] && item.canFocus)
            return [NSIndexPath indexPathForRow:i inSection:sectionIndex];
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
        if (item.canFocus)
            return [NSIndexPath indexPathForRow:i inSection:sectionIndex];
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
}

- (void)actionBar:(REActionBar *)actionBar doneButtonPressed:(UIBarButtonItem *)doneButtonItem
{
    [self endEditing:YES];
}

@end
