//
//  REInlineDatePickerItem.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 10/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewItem.h"

@class REDateTimeItem;

@interface REInlineDatePickerItem : RETableViewItem

@property (strong, readwrite, nonatomic) NSDate *value;
@property (assign, readwrite, nonatomic) UIDatePickerMode datePickerMode; // default is UIDatePickerModeDateAndTime

@property (strong, readwrite, nonatomic) NSLocale *locale;                // default is [NSLocale currentLocale]. setting nil returns to default
@property (copy, readwrite, nonatomic) NSCalendar *calendar;              // default is [NSCalendar currentCalendar]. setting nil returns to default
@property (strong, readwrite, nonatomic) NSTimeZone *timeZone;              // default is nil. use current time zone or time zone from calendar

@property (strong, readwrite, nonatomic) NSDate *minimumDate;           // specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode
@property (strong, readwrite, nonatomic) NSDate *maximumDate;           // default is nil
@property (assign, readwrite, nonatomic) NSInteger minuteInterval;        // display minutes wheel with interval. interval must be evenly divided into 60. default is 1. min is 1, max is 30
@property (copy, readwrite, nonatomic) void (^onChange)(REInlineDatePickerItem *item);
@property (weak, readwrite, nonatomic) REDateTimeItem *dateTimeItem;

+ (instancetype)itemWithDatePickerMode:(UIDatePickerMode)datePickerMode;
- (id)initWithDatePickerMode:(UIDatePickerMode)datePickerMode;

@end
