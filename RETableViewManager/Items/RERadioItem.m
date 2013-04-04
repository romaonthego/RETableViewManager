//
//  RERadioItem.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RERadioItem.h"

@implementation RERadioItem

+ (id)itemWithTitle:(NSString *)title value:(NSString *)value actionBlock:(void(^)(RETableViewItem *item))actionBlock
{
    return [[RERadioItem alloc] initWithTitle:title value:value actionBlock:actionBlock];
}

- (id)initWithTitle:(NSString *)title value:(NSString *)value actionBlock:(void(^)(RETableViewItem *item))actionBlock
{
    self = [super init];
    if (!self)
        return nil;
    
    self.title = title;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.actionBlock = actionBlock;
    self.performActionOnSelection = YES;
    self.value = value;
    self.cellStyle = UITableViewCellStyleValue1;
    
    return self;
}

@end
