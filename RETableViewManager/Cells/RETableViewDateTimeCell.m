//
// RETableViewDateTimeCell.m
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
#import "RETableViewDateTimeCell.h"
#import "RETableViewManager.h"

@implementation RETableViewDateTimeCell

+ (BOOL)canFocusWithItem:(RETableViewItem *)item
{
    return YES;
}

#pragma mark -
#pragma mark Lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.selectionStyle = self.tableViewManager.style.defaultCellSelectionStyle;
    
    _textField = [[UITextField alloc] initWithFrame:CGRectNull];
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.inputAccessoryView = self.actionBar;
    _textField.delegate = self;
    [self addSubview:_textField];
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectNull];
    _dateLabel.font = [UIFont systemFontOfSize:17];
    _dateLabel.backgroundColor = [UIColor clearColor];
    _dateLabel.textColor = self.detailTextLabel.textColor;
    _dateLabel.highlightedTextColor = [UIColor whiteColor];
    _dateLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_dateLabel];
    
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectNull];
    _placeholderLabel.font = [UIFont systemFontOfSize:17];
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    _placeholderLabel.textColor = [UIColor lightGrayColor];
    _placeholderLabel.highlightedTextColor = [UIColor whiteColor];
    _placeholderLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_placeholderLabel];
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker addTarget:self action:@selector(datePickerValueDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)cellWillAppear
{
    self.textLabel.text = self.item.title;
    self.textField.inputView = _datePicker;
    _datePicker.date = self.item.value ? self.item.value : [NSDate date];
    _datePicker.datePickerMode = self.item.datePickerMode;
    _datePicker.locale = self.item.locale;
    _datePicker.calendar = self.item.calendar;
    _datePicker.timeZone = self.item.timeZone;
    _datePicker.minimumDate = self.item.minimumDate;
    _datePicker.maximumDate = self.item.maximumDate;
    _datePicker.minuteInterval = self.item.minuteInterval;
    _dateFormatter.dateFormat = self.item.format;
    _dateLabel.text = self.item.value ? [_dateFormatter stringFromDate:self.item.value] : @"";
    _placeholderLabel.text = self.item.placeholder;
    _placeholderLabel.hidden = self.dateLabel.text.length > 0;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textField.frame = CGRectNull;
    self.textField.alpha = 0;
    
    CGFloat cellOffset = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 10 : 40;
    CGFloat fieldOffset = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 10 : 40;
    CGFloat width = 0;
    CGRect frame = CGRectMake(0, self.tableViewManager.style.textFieldPositionOffset.height - 1, 0, self.contentView.frame.size.height - self.tableViewManager.style.textFieldPositionOffset.height);
    if (self.item.title && ![self.item.title isEqualToString:@""]) {
        for (RETableViewItem *item in self.section.items) {
            if ([item isMemberOfClass:[RETextItem class]] || [item isMemberOfClass:[REDateTimeItem class]]) {
                CGSize size = [item.title sizeWithFont:self.textLabel.font];
                width = MAX(width, size.width);
            }
        }
        frame.origin.x = width + cellOffset + fieldOffset + self.tableViewManager.style.textFieldPositionOffset.width;
    } else {
        frame.origin.x = cellOffset + self.tableViewManager.style.textFieldPositionOffset.width;
    }
    frame.size.width = self.contentView.frame.size.width - frame.origin.x - cellOffset;
    _dateLabel.frame = frame;
    _placeholderLabel.frame = _dateLabel.frame;
    
    if ([self.tableViewManager.delegate respondsToSelector:@selector(tableView:cellWillLayoutSubviews:)])
        [self.tableViewManager.delegate tableView:self.tableViewManager.tableView cellWillLayoutSubviews:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        [_textField becomeFirstResponder];
    }
}

- (UIResponder *)responder
{
    return _textField;
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!self.selected)
        [self setSelected:YES animated:NO];
    NSIndexPath *indexPath = [self indexPathForNextResponder];
    if (indexPath) {
        textField.returnKeyType = UIReturnKeyNext;
    } else {
        textField.returnKeyType = UIReturnKeyDefault;
    }
    [self updateActionBarNavigationControl];
    [self.parentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.row inSection:self.sectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self setSelected:NO animated:NO];
    self.item.value = _datePicker.date;
    self.dateLabel.text = [_dateFormatter stringFromDate:self.item.value];
    self.placeholderLabel.hidden = self.dateLabel.text.length > 0;
    return YES;
}

#pragma mark -
#pragma mark Date picker value

- (void)datePickerValueDidChange:(UIDatePicker *)datePicker
{
    self.item.value = _datePicker.date;
    self.dateLabel.text = [_dateFormatter stringFromDate:self.item.value];
    self.placeholderLabel.hidden = self.dateLabel.text.length > 0;
}

@end
