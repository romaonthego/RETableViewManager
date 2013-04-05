//
//  RERadioItem.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewItem.h"

@interface RERadioItem : RETableViewItem

@property (copy, readwrite, nonatomic, getter = detailLabelText, setter = setDetailLabelText:) NSString *value;

+ (id)itemWithTitle:(NSString *)title value:(NSString *)value actionBlock:(void(^)(RERadioItem *item))actionBlock;
- (id)initWithTitle:(NSString *)title value:(NSString *)value actionBlock:(void(^)(RERadioItem *item))actionBlock;

@end
