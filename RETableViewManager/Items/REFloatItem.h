//
//  REFloatItem.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/5/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewItem.h"

@interface REFloatItem : RETableViewItem

@property (assign, readwrite, nonatomic) float value;
@property (assign, readwrite, nonatomic) CGFloat sliderWidth;

+ (id)itemWithTitle:(NSString *)title value:(float)value actionBlock:(void(^)(REFloatItem *item))actionBlock;
+ (id)itemWithTitle:(NSString *)title value:(float)value;

- (id)initWithTitle:(NSString *)title value:(float)value actionBlock:(void(^)(REFloatItem *item))actionBlock;
- (id)initWithTitle:(NSString *)title value:(float)value;

@end
