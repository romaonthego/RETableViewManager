//
//  ListImageItem.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/2/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewItem.h"

@interface ListImageItem : RETableViewItem

@property (strong, readwrite, nonatomic) NSURL *imageURL;

+ (ListImageItem *)itemWithImageURL:(NSURL *)imageURL;

@end
