//
//  REDateTimeItem.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/5/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "REDateTimeItem.h"

@implementation REDateTimeItem

+ (id)itemWithTitle:(NSString *)title value:(NSDate *)value format:(NSString *)format
{
    return [[REDateTimeItem alloc] initWithTitle:title value:value format:format];
}

+ (id)itemWithTitle:(NSString *)title value:(NSDate *)value format:(NSString *)format datePickerMode:(UIDatePickerMode)datePickerMode
{
    return [[REDateTimeItem alloc] initWithTitle:title value:value format:format datePickerMode:datePickerMode];
}

- (id)initWithTitle:(NSString *)title value:(NSDate *)value format:(NSString *)format
{
    return [self initWithTitle:title value:value format:format datePickerMode:UIDatePickerModeDateAndTime];
}

- (id)initWithTitle:(NSString *)title value:(NSDate *)value format:(NSString *)format datePickerMode:(UIDatePickerMode)datePickerMode
{
    self = [super init];
    if (!self)
        return nil;
    
    self.title = title;
    self.value = value;
    self.format = format;
    self.datePickerMode = datePickerMode;
    self.cellStyle = UITableViewCellStyleValue1;
    
    return self;
}

@end
