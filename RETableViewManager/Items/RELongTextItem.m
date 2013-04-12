//
//  RELongTextItem.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/11/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RELongTextItem.h"

@implementation RELongTextItem

+ (id)itemWithValue:(NSString *)value placeholder:(NSString *)placeholder
{
    return [[self alloc] initWithValue:value placeholder:placeholder];
}

- (id)init
{
    self = [super init];
    if (!self)
        return nil;
    
    self.placeholderColor = [UIColor lightGrayColor];
    self.editable = YES;
    
    return self;
}

- (id)initWithValue:(NSString *)value placeholder:(NSString *)placeholder
{
    return [self initWithTitle:nil value:value placeholder:placeholder];
}

- (id)initWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder
{
    self = [super initWithTitle:title value:value placeholder:placeholder];
    if (!self)
        return nil;
    
    self.placeholderColor = [UIColor lightGrayColor];
    self.editable = YES;
    
    return self;
}

@end
