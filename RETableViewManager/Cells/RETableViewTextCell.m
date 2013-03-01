//
// RETableViewTextCell.m
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

#import "RETableViewTextCell.h"

@implementation RETableViewTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.backgroundColor = [UIColor clearColor];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            _textField = [[UITextField alloc] initWithFrame:CGRectMake(140, 0, self.frame.size.width - 160, self.frame.size.height)];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            _textField = [[UITextField alloc] initWithFrame:CGRectMake(160, 0, self.frame.size.width - 200, self.frame.size.height)];
        
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _textField.inputAccessoryView = [self createActionBar];
        
        _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_textField];
    }
    return self;
}

- (UIToolbar *)createActionBar
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
    
    [_prevNext setEnabled:[self indexPathForPreviousTextField] != nil forSegmentAtIndex:0];
    [_prevNext setEnabled:[self indexPathForNextTextField] != nil forSegmentAtIndex:1];
}

- (NSIndexPath *)indexPathForPreviousTextField
{
    NSUInteger indexInSection = [self.section.items indexOfObject:self.item];
    for (NSInteger i = indexInSection - 1; i >= 0; i--) {
        id item = [self.section.items objectAtIndex:i];
        if ([item isKindOfClass:[RETextItem class]]) {
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
        id item = [self.section.items objectAtIndex:i];
        if ([item isKindOfClass:[RETextItem class]]) {
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
            _textField.frame = CGRectMake(140, 0, self.frame.size.width - 160, self.frame.size.height);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            _textField.frame = CGRectMake(160, 0, self.frame.size.width - 200, self.frame.size.height);
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            _textField.frame = CGRectMake(20, 0, self.frame.size.width - 40, self.frame.size.height);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            _textField.frame = CGRectMake(40, 0, self.frame.size.width - 80, self.frame.size.height);
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
    NSIndexPath *indexPath = [self indexPathForNextTextField];
    if (indexPath) {
        textField.returnKeyType = UIReturnKeyNext;
    } else {
        textField.returnKeyType = UIReturnKeyDefault;
    }
    
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
