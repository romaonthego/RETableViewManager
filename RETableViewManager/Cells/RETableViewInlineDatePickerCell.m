//
//  RETableViewInlineDatePickerCell.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 10/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewInlineDatePickerCell.h"
#import "REDateTimeItem.h"

@interface RETableViewInlineDatePickerCell ()

@property (strong, readwrite, nonatomic) UIDatePicker *datePicker;

@end

@implementation RETableViewInlineDatePickerCell

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 216.0f;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.datePicker = [[UIDatePicker alloc] init];
    [self.contentView addSubview:self.datePicker];
    [self.datePicker addTarget:self action:@selector(datePickerValueDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.datePicker.date = self.item.dateTimeItem.value ? self.item.dateTimeItem.value : [NSDate date];
    self.datePicker.datePickerMode = self.item.dateTimeItem.datePickerMode;
    self.datePicker.locale = self.item.dateTimeItem.locale;
    self.datePicker.calendar = self.item.dateTimeItem.calendar;
    self.datePicker.timeZone = self.item.dateTimeItem.timeZone;
    self.datePicker.minimumDate = self.item.dateTimeItem.minimumDate;
    self.datePicker.maximumDate = self.item.dateTimeItem.maximumDate;
    self.datePicker.minuteInterval = self.item.dateTimeItem.minuteInterval;
}

#pragma mark -
#pragma mark Date picker value

- (void)datePickerValueDidChange:(UIDatePicker *)datePicker
{
    self.item.dateTimeItem.value = self.datePicker.date;
    if (self.item.dateTimeItem) {
        self.item.dateTimeItem.value = self.datePicker.date;
        if (self.item.dateTimeItem.onChange)
            self.item.dateTimeItem.onChange(self.item.dateTimeItem);
        [self.item.dateTimeItem reloadRowWithAnimation:UITableViewRowAnimationNone];
    }
}

@end
