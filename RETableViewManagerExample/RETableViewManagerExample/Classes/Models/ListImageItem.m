//
//  ListImageItem.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/2/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ListImageItem.h"

@implementation ListImageItem

+ (ListImageItem *)itemWithImageNamed:(NSString *)imageName
{
    ListImageItem *item = [[ListImageItem alloc] init];
    item.imageName = imageName;
    return item;
}

@end
