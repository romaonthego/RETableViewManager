//
//  ListImageItem.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/2/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewItem.h"

@interface ListImageItem : RETableViewItem

@property (copy, readwrite, nonatomic) NSString *imageName;

+ (ListImageItem *)itemWithImageNamed:(NSString *)imageName;

@end
