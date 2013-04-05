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
@property (assign, readwrite, nonatomic) UIDatePickerMode datePickerMode;

+ (id)itemWithTitle:(NSString *)title value:(NSDate *)value format:(NSString *)format;
- (id)initWithTitle:(NSString *)title value:(NSDate *)value format:(NSString *)format;

@end
