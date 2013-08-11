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
#import "RETableViewManager.h"

@implementation RETableViewTextCell

+ (BOOL)canFocusWithItem:(RETableViewItem *)item
{
    return YES;
}

#pragma mark -
#pragma mark Lifecycle

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectNull];
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.inputAccessoryView = self.actionBar;
    _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _textField.delegate = self;
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:_textField];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        [_textField becomeFirstResponder];
    }
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.textLabel.text = self.item.title.length == 0 ? @" " : self.item.title;
    _textField.text = self.item.value;
    _textField.placeholder = self.item.placeholder;
    _textField.font = [UIFont systemFontOfSize:17];
    _textField.autocapitalizationType = self.item.autocapitalizationType;
    _textField.autocorrectionType = self.item.autocorrectionType;
    _textField.spellCheckingType = self.item.spellCheckingType;
    _textField.keyboardType = self.item.keyboardType;
    _textField.keyboardAppearance = self.item.keyboardAppearance;
    _textField.returnKeyType = self.item.returnKeyType;
    _textField.enablesReturnKeyAutomatically = self.item.enablesReturnKeyAutomatically;
    _textField.secureTextEntry = self.item.secureTextEntry;
    _textField.clearButtonMode = self.item.clearButtonMode;
    _textField.clearsOnBeginEditing = self.item.clearsOnBeginEditing;
}

- (UIResponder *)responder
{
    return _textField;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layoutDetailView:_textField minimumWidth:0];
    
    if ([self.tableViewManager.delegate respondsToSelector:@selector(tableView:willLayoutCellSubviews:forRowAtIndexPath:)])
        [self.tableViewManager.delegate tableView:self.tableViewManager.tableView willLayoutCellSubviews:self forRowAtIndexPath:[(UITableView *)self.superview indexPathForCell:self]];
}

#pragma mark -
#pragma mark Text field events

- (void)textFieldDidChange:(UITextField *)textField
{
    self.item.value = textField.text;
    if (self.item.onChange)
        self.item.onChange(self.item);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSIndexPath *indexPath = [self indexPathForNextResponder];
    if (indexPath) {
        textField.returnKeyType = UIReturnKeyNext;
    } else {
        textField.returnKeyType = self.item.returnKeyType;
    }
    [self updateActionBarNavigationControl];
    [self.parentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.rowIndex inSection:self.sectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    if (self.item.onBeginEditing)
        self.item.onBeginEditing(self.item);
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.item.onEndEditing)
        self.item.onEndEditing(self.item);
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.item.onReturn)
        self.item.onReturn(self.item);
    NSIndexPath *indexPath = [self indexPathForNextResponder];
    if (!indexPath) {
        [self endEditing:YES];
        return YES;
    }
    RETableViewCell *cell = (RETableViewCell *)[self.parentTableView cellForRowAtIndexPath:indexPath];
    [cell.responder becomeFirstResponder];
    return YES;
}

@end
