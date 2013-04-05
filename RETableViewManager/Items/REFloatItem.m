//
//  REFloatItem.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/5/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "REFloatItem.h"

@implementation REFloatItem

+ (id)itemWithTitle:(NSString *)title value:(float)value
{
    return [[REFloatItem alloc] initWithTitle:title value:value];
}

+ (id)itemWithTitle:(NSString *)title value:(float)value actionBlock:(void(^)(REFloatItem *item))actionBlock
{
    return [[REFloatItem alloc] initWithTitle:title value:value actionBlock:actionBlock];
}

- (id)initWithTitle:(NSString *)title value:(float)value
{
    return [self initWithTitle:title value:value actionBlock:nil];
}

- (id)initWithTitle:(NSString *)title value:(float)value actionBlock:(void(^)(REFloatItem *item))actionBlock
{
    self = [super init];
    if (!self)
        return nil;
    
    self.title = title;
    self.value = value;
    self.actionBlock = actionBlock;
    self.sliderWidth = 140.0;
    
    return self;
}

@end
