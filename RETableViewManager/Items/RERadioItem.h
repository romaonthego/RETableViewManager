//
//  RERadioItem.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "REStringItem.h"

@interface RERadioItem : REStringItem

@property (copy, readwrite, nonatomic, getter = detailLabelText, setter = setDetailLabelText:) NSString *value;

+ (id)itemWithTitle:(NSString *)title value:(NSString *)value actionBlock:(void(^)(RETableViewItem *item))actionBlock;
- (id)initWithTitle:(NSString *)title value:(NSString *)value actionBlock:(void(^)(RETableViewItem *item))actionBlock;

@end
