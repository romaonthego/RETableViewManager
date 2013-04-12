//
//  RELongTextItem.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/11/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETextItem.h"

@interface RELongTextItem : RETextItem

@property (strong, readwrite, nonatomic) UIColor *placeholderColor;
@property (assign, readwrite, nonatomic) BOOL editable;

+ (id)itemWithValue:(NSString *)value placeholder:(NSString *)placeholder;
- (id)initWithValue:(NSString *)value placeholder:(NSString *)placeholder;

@end
