//
//  REInlineDatePickerItem.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 10/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "REInlineDatePickerItem.h"

@implementation REInlineDatePickerItem

+ (instancetype)itemWithDateTimeItem:(REDateTimeItem *)dateTimeItem
{
    return [[self alloc] initWithDateTimeItem:dateTimeItem];
}

- (id)initWithDateTimeItem:(REDateTimeItem *)dateTimeItem
{
    self = [super init];
    if (!self)
        return nil;
    
    _dateTimeItem = dateTimeItem;
    
    return self;
}

@end
