//
//  REDateTimeItem.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/5/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewItem.h"

@interface REDateTimeItem : RETableViewItem

@property (strong, readwrite, nonatomic) NSDate *value;
@property (strong, readwrite, nonatomic) NSString *format;
@property (assign, readwrite, nonatomic) UIDatePickerMode datePickerMode; // default is UIDatePickerModeDateAndTime

@property (strong, readwrite, nonatomic) NSLocale *locale;                // default is [NSLocale currentLocale]. setting nil returns to default
@property (copy, readwrite, nonatomic) NSCalendar *calendar;              // default is [NSCalendar currentCalendar]. setting nil returns to default
@property (strong, readwrite, nonatomic) NSTimeZone *timeZone;              // default is nil. use current time zone or time zone from calendar

@property (strong, readwrite, nonatomic) NSDate *minimumDate;           // specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode
@property (strong, readwrite, nonatomic) NSDate *maximumDate;           // default is nil
@property (assign, readwrite, nonatomic) NSInteger minuteInterval;        // display minutes wheel with interval. interval must be evenly divided into 60. default is 1. min is 1, max is 30

+ (id)itemWithTitle:(NSString *)title value:(NSDate *)value format:(NSString *)format;
+ (id)itemWithTitle:(NSString *)title value:(NSDate *)value format:(NSString *)format datePickerMode:(UIDatePickerMode)datePickerMode;
- (id)initWithTitle:(NSString *)title value:(NSDate *)value format:(NSString *)format;
- (id)initWithTitle:(NSString *)title value:(NSDate *)value format:(NSString *)format datePickerMode:(UIDatePickerMode)datePickerMode;

@end
