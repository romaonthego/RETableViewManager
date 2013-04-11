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
    return [[self alloc] initWithTitle:@"" value:value placeholder:placeholder];
}

@end
