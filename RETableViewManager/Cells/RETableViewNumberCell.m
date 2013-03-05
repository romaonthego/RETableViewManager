//
//  RETableViewNumberCell.m
//  Meungry
//
//  Created by Roman Efimov on 3/5/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewNumberCell.h"
#import "RETableViewManager.h"

@implementation RETableViewNumberCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableViewManager:(RETableViewManager *)tableViewManager
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier tableViewManager:(RETableViewManager *)tableViewManager];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.backgroundColor = [UIColor clearColor];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            _textField = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(140, 0, self.frame.size.width - 160, self.frame.size.height)];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            _textField = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(160, 0, self.frame.size.width - 200, self.frame.size.height)];
        
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.inputAccessoryView = [self actionBar];
        _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_textField];
    }
    return self;
}

- (UIToolbar *)actionBar
{
    UIToolbar *actionBar = [[UIToolbar alloc] init];
    actionBar.translucent = YES;
    [actionBar sizeToFit];
    actionBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"")
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(handleActionBarDone:)];
    
    _prevNext = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Previous", @""), NSLocalizedString(@"Next", @""), nil]];
    _prevNext.momentary = YES;
    _prevNext.segmentedControlStyle = UISegmentedControlStyleBar;
    _prevNext.tintColor = actionBar.tintColor;
    [_prevNext addTarget:self action:@selector(handleActionBarPreviousNext:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *prevNextWrapper = [[UIBarButtonItem alloc] initWithCustomView:_prevNext];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [actionBar setItems:[NSArray arrayWithObjects:prevNextWrapper, flexible, doneButton, nil]];
    
	return actionBar;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        [_textField becomeFirstResponder];
    }
}

- (void)prepare
{
    self.textLabel.text = self.item.title;
    _textField.text = self.item.value;
    _textField.placeholder = self.item.placeholder;
    _textField.format = self.item.format;
    _textField.font = self.tableViewManager.style.textFieldFont;
    _textFieldPositionOffset = self.tableViewManager.style.textFieldPositionOffset;
    
    [_prevNext setEnabled:[self indexPathForPreviousTextField] != nil forSegmentAtIndex:0];
    [_prevNext setEnabled:[self indexPathForNextTextField] != nil forSegmentAtIndex:1];
}

- (NSIndexPath *)indexPathForPreviousTextField
{
    NSUInteger indexInSection = [self.section.items indexOfObject:self.item];
    for (NSInteger i = indexInSection - 1; i >= 0; i--) {
        RETableViewItem *item = [self.section.items objectAtIndex:i];
        if (item.canFocus) {
            return [NSIndexPath indexPathForRow:i inSection:self.sectionIndex];
            break;
        }
    }
    return nil;
}

- (NSIndexPath *)indexPathForNextTextField
{
    NSUInteger indexInSection = [self.section.items indexOfObject:self.item];
    for (NSInteger i = indexInSection + 1; i < self.section.items.count; i++) {
        RETableViewItem *item = [self.section.items objectAtIndex:i];
        if (item.canFocus) {
            return [NSIndexPath indexPathForRow:i inSection:self.sectionIndex];
            break;
        }
    }
    return nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.item.title) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            _textField.frame = CGRectMake(140 + _textFieldPositionOffset.width, _textFieldPositionOffset.height, self.frame.size.width - 160, self.frame.size.height - _textFieldPositionOffset.height);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            _textField.frame = CGRectMake(160+ _textFieldPositionOffset.width, _textFieldPositionOffset.height, self.frame.size.width - 200, self.frame.size.height - _textFieldPositionOffset.height);
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            _textField.frame = CGRectMake(20+ _textFieldPositionOffset.width, _textFieldPositionOffset.height, self.frame.size.width - 40, self.frame.size.height - _textFieldPositionOffset.height);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            _textField.frame = CGRectMake(40+ _textFieldPositionOffset.width, _textFieldPositionOffset.height, self.frame.size.width - 80, self.frame.size.height - _textFieldPositionOffset.height);
    }
}

#pragma mark -
#pragma mark UISwitch events

- (void)textFieldDidChange:(UITextField *)textField
{
    self.item.value = textField.text;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.parentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.row inSection:self.sectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSIndexPath *indexPath = [self indexPathForNextTextField];
    if (!indexPath) {
        [_textField resignFirstResponder];
        return YES;
    }
    UITableViewCell *cell = [self.parentTableView cellForRowAtIndexPath:indexPath];
    for (id object in cell.subviews) {
        if ([object isKindOfClass:[UITextField class]]) {
            UITextField *textField = object;
            [textField becomeFirstResponder];
        }
    }
    return YES;
}

#pragma mark -
#pragma mark Action bar

- (void)handleActionBarPreviousNext:(UISegmentedControl *)segmentedControl
{
    if (segmentedControl.selectedSegmentIndex == 0) {
        NSIndexPath *indexPath = [self indexPathForPreviousTextField];
        if (indexPath) {
            UITableViewCell *cell = [self.parentTableView cellForRowAtIndexPath:indexPath];
            if (!cell)
                [self.parentTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            cell = [self.parentTableView cellForRowAtIndexPath:indexPath];
            for (id object in cell.subviews) {
                if ([object isKindOfClass:[UITextField class]]) {
                    UITextField *textField = object;
                    [textField becomeFirstResponder];
                }
            }
        }
    } else {
        NSIndexPath *indexPath = [self indexPathForNextTextField];
        if (indexPath) {
            UITableViewCell *cell = [self.parentTableView cellForRowAtIndexPath:indexPath];
            if (!cell)
                [self.parentTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            cell = [self.parentTableView cellForRowAtIndexPath:indexPath];
            for (id object in cell.subviews) {
                if ([object isKindOfClass:[UITextField class]]) {
                    UITextField *textField = object;
                    [textField becomeFirstResponder];
                }
            }
        }
    }
}

- (void)handleActionBarDone:(UIBarButtonItem *)doneButtonItem
{
    [_textField resignFirstResponder];
}

@end
