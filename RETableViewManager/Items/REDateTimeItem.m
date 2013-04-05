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

- (id)initWithTitle:(NSString *)title value:(NSDate *)value format:(NSString *)format
{
    self = [super init];
    if (!self)
        return nil;
    
    self.title = title;
    self.value = value;
    self.format = format;
    self.datePickerMode = UIDatePickerModeDateAndTime;
    self.cellStyle = UITableViewCellStyleValue1;
    
    return self;
}

- (BOOL)canFocus
{
    return YES;
}

@end
