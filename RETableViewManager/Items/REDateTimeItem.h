//
// REDateTimeItem.h
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

#import "RETableViewItem.h"
#import "REInlineDatePickerItem.h"

@interface REDateTimeItem : RETableViewItem

@property (strong, readwrite, nonatomic) NSDate *value;
@property (strong, readwrite, nonatomic) NSDate *pickerStartDate;         // date to be used for the picker when the value is not set; defaults to current date when not specified
@property (copy, readwrite, nonatomic) NSString *placeholder;
@property (strong, readwrite, nonatomic) NSString *format;
@property (assign, readwrite, nonatomic) UIDatePickerMode datePickerMode; // default is UIDatePickerModeDateAndTime

@property (strong, readwrite, nonatomic) NSLocale *locale;                // default is [NSLocale currentLocale]. setting nil returns to default
@property (copy, readwrite, nonatomic) NSCalendar *calendar;              // default is [NSCalendar currentCalendar]. setting nil returns to default
@property (strong, readwrite, nonatomic) NSTimeZone *timeZone;              // default is nil. use current time zone or time zone from calendar

@property (strong, readwrite, nonatomic) NSDate *minimumDate;           // specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode
@property (strong, readwrite, nonatomic) NSDate *maximumDate;           // default is nil
@property (assign, readwrite, nonatomic) NSInteger minuteInterval;        // display minutes wheel with interval. interval must be evenly divided into 60. default is 1. min is 1, max is 30
@property (copy, readwrite, nonatomic) void (^onChange)(REDateTimeItem *item);
@property (assign, readwrite, nonatomic) BOOL inlineDatePicker;
@property (strong, readwrite, nonatomic) REInlineDatePickerItem *inlinePickerItem;

+ (instancetype)itemWithTitle:(NSString *)title value:(NSDate *)value placeholder:(NSString *)placeholder format:(NSString *)format datePickerMode:(UIDatePickerMode)datePickerMode;
- (id)initWithTitle:(NSString *)title value:(NSDate *)value placeholder:(NSString *)placeholder format:(NSString *)format datePickerMode:(UIDatePickerMode)datePickerMode;

@end
