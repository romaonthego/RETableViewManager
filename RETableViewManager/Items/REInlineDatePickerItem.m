//
//  REInlineDatePickerItem.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 10/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "REInlineDatePickerItem.h"

@implementation REInlineDatePickerItem

+ (instancetype)itemWithDatePickerMode:(UIDatePickerMode)datePickerMode
{
    return [[self alloc] initWithDatePickerMode:datePickerMode];
}

- (id)initWithDatePickerMode:(UIDatePickerMode)datePickerMode
{
    self = [super init];
    if (!self)
        return nil;
    
    _datePickerMode = datePickerMode;
    
    return self;
}

@end
