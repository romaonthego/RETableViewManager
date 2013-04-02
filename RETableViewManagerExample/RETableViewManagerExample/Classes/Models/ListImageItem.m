//
//  ListImageItem.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/2/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ListImageItem.h"

@implementation ListImageItem

+ (ListImageItem *)itemWithImageURL:(NSURL *)imageURL
{
    ListImageItem *item = [[ListImageItem alloc] init];
    item.imageURL = imageURL;
    return item;
}

@end
