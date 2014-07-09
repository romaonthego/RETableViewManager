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
#import "NSString+RETableViewManagerAdditions.h"

@interface RETableViewDateTimeCell ()

@property (strong, readwrite, nonatomic) UITextField *textField;
@property (strong, readwrite, nonatomic) UILabel *dateLabel;
@property (strong, readwrite, nonatomic) UILabel *placeholderLabel;
@property (strong, readwrite, nonatomic) UIDatePicker *datePicker;
@property (strong, readwrite, nonatomic) NSDateFormatter *dateFormatter;

@property (assign, readwrite, nonatomic) BOOL enabled;

@end

@implementation RETableViewDateTimeCell

+ (BOOL)canFocusWithItem:(REDateTimeItem *)item
{
    return !item.inlineDatePicker;
}

@synthesize item = _item;

#pragma mark -
#pragma mark Lifecycle

- (void)dealloc {
    if (_item != nil) {
        [_item removeObserver:self forKeyPath:@"enabled"];
    }
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectNull];
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField.inputAccessoryView = self.actionBar;
    self.textField.delegate = self;
    [self addSubview:self.textField];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectNull];
    self.dateLabel.font = [UIFont systemFontOfSize:17];
    self.dateLabel.backgroundColor = [UIColor clearColor];
    self.dateLabel.textColor = self.detailTextLabel.textColor;
    self.dateLabel.highlightedTextColor = [UIColor whiteColor];
    self.dateLabel.textAlignment = NSTextAlignmentRight;
    self.dateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:self.dateLabel];
    
    self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectNull];
    self.placeholderLabel.font = [UIFont systemFontOfSize:17];
    self.placeholderLabel.backgroundColor = [UIColor clearColor];
    self.placeholderLabel.textColor = [UIColor lightGrayColor];
    self.placeholderLabel.highlightedTextColor = [UIColor whiteColor];
    [self.contentView addSubview:self.placeholderLabel];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    
    self.datePicker = [[UIDatePicker alloc] init];
    [self.datePicker addTarget:self action:@selector(datePickerValueDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)cellWillAppear
{
    self.textLabel.text = self.item.title.length == 0 ? @" " : self.item.title;
    self.textField.inputView = self.datePicker;
    self.datePicker.date = self.item.value ? self.item.value : (self.item.pickerStartDate ? self.item.pickerStartDate : [NSDate date]);
    self.datePicker.datePickerMode = self.item.datePickerMode;
    self.datePicker.locale = self.item.locale;
    self.datePicker.calendar = self.item.calendar;
    self.datePicker.timeZone = self.item.timeZone;
    self.datePicker.minimumDate = self.item.minimumDate;
    self.datePicker.maximumDate = self.item.maximumDate;
    self.datePicker.minuteInterval = self.item.minuteInterval;
    self.dateFormatter.dateFormat = self.item.format;
    self.dateFormatter.calendar = self.item.calendar;
    self.dateFormatter.timeZone = self.item.timeZone;
    self.dateFormatter.locale = self.item.locale;
    self.dateLabel.text = self.item.value ? [self.dateFormatter stringFromDate:self.item.value] : @"";
    self.placeholderLabel.text = self.item.placeholder;
    self.placeholderLabel.hidden = self.dateLabel.text.length > 0;
    
    if (!self.item.title) {
        self.dateLabel.textAlignment = NSTextAlignmentLeft;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    self.dateLabel.textColor = self.item.inlinePickerItem ? [self performSelector:@selector(tintColor) withObject:nil] : self.detailTextLabel.textColor;
#endif

    self.enabled = self.item.enabled;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textField.frame = CGRectNull;
    self.textField.alpha = 0;
    
    [self layoutDetailView:self.dateLabel minimumWidth:[self.dateLabel.text re_sizeWithFont:self.dateLabel.font].width];
    [self layoutDetailView:self.placeholderLabel minimumWidth:[self.placeholderLabel.text re_sizeWithFont:self.placeholderLabel.font].width];
    
    if ([self.tableViewManager.delegate respondsToSelector:@selector(tableView:willLayoutCellSubviews:forRowAtIndexPath:)])
        [self.tableViewManager.delegate tableView:self.tableViewManager.tableView willLayoutCellSubviews:self forRowAtIndexPath:[self.tableViewManager.tableView indexPathForCell:self]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected && !self.item.inlineDatePicker) {
        [self.textField becomeFirstResponder];
    }
    
    if (selected && self.item.inlineDatePicker && !self.item.inlinePickerItem) {
        [self setSelected:NO animated:NO];
        [self.item deselectRowAnimated:NO];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
        self.dateLabel.textColor = [self performSelector:@selector(tintColor) withObject:nil];
#endif
        self.item.inlinePickerItem = [REInlineDatePickerItem itemWithDateTimeItem:self.item];
        [self.section insertItem:self.item.inlinePickerItem atIndex:self.item.indexPath.row + 1];
        [self.tableViewManager.tableView insertRowsAtIndexPaths:@[self.item.inlinePickerItem.indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        if (selected && self.item.inlineDatePicker && self.item.inlinePickerItem) {
            [self setSelected:NO animated:NO];
            [self.item deselectRowAnimated:NO];
            self.dateLabel.textColor = self.detailTextLabel.textColor;
            NSIndexPath *indexPath = [self.item.inlinePickerItem.indexPath copy];
            [self.section removeItemAtIndex:self.item.inlinePickerItem.indexPath.row];
            self.item.inlinePickerItem = nil;
            [self.tableViewManager.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

- (UIResponder *)responder
{
    return self.textField;
}

#pragma mark -
#pragma mark Handle state

- (void)setItem:(REDateTimeItem *)item
{
    if (_item != nil) {
        [_item removeObserver:self forKeyPath:@"enabled"];
    }
    
    _item = item;
    
    [_item addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    
    self.userInteractionEnabled = _enabled;
    
    self.textLabel.enabled = _enabled;
    self.textField.enabled = _enabled;
    self.dateLabel.enabled = _enabled;
    self.placeholderLabel.enabled = _enabled;
    self.datePicker.enabled = _enabled;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[REBoolItem class]] && [keyPath isEqualToString:@"enabled"]) {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.enabled = newValue;
    }
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
    [self.parentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.rowIndex inSection:self.sectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self setSelected:NO animated:NO];
    [self.item deselectRowAnimated:NO];
    self.item.value = self.datePicker.date;
    self.dateLabel.text = [self.dateFormatter stringFromDate:self.item.value];
    self.placeholderLabel.hidden = self.dateLabel.text.length > 0;
    return YES;
}

#pragma mark -
#pragma mark Date picker value

- (void)datePickerValueDidChange:(UIDatePicker *)datePicker
{
    self.item.value = self.datePicker.date;
    self.dateLabel.text = [self.dateFormatter stringFromDate:self.item.value];
    self.placeholderLabel.hidden = self.dateLabel.text.length > 0;
    if (self.item.onChange)
        self.item.onChange(self.item);
}

@end
