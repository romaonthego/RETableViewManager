//
//  RETableViewDateTimeCell.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/5/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewDateTimeCell.h"
#import "RETableViewManager.h"

@implementation RETableViewDateTimeCell

+ (BOOL)canFocus
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
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker addTarget:self action:@selector(datePickerValueDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)cellWillAppear
{
    self.textLabel.text = self.item.title;
    self.textField.inputView = _datePicker;
    
    _datePicker.date = self.item.value;
    _datePicker.datePickerMode = self.item.datePickerMode;
    _datePicker.locale = self.item.locale;
    _datePicker.calendar = self.item.calendar;
    _datePicker.timeZone = self.item.timeZone;
    _datePicker.minimumDate = self.item.minimumDate;
    _datePicker.maximumDate = self.item.maximumDate;
    _datePicker.minuteInterval = self.item.minuteInterval;
    
    _dateFormatter.dateFormat = self.item.format;
    self.detailTextLabel.text = [_dateFormatter stringFromDate:self.item.value];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textField.frame = CGRectNull;
    self.textField.alpha = 0;
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
    self.detailTextLabel.text = [_dateFormatter stringFromDate:self.item.value];
    return YES;
}

#pragma mark -
#pragma mark Date picker value

- (void)datePickerValueDidChange:(UIDatePicker *)datePicker
{
    self.item.value = _datePicker.date;
    self.detailTextLabel.text = [_dateFormatter stringFromDate:self.item.value];
}

@end
