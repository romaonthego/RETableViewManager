//
//  REDateTimeItem.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/5/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewItem.h"

@interface REDateTimeItem : RETableViewItem

@property (assign, readwrite, nonatomic) NSDate *value;

+ (id)itemWithTitle:(NSString *)title value:(NSDate *)value;
- (id)initWithTitle:(NSString *)title value:(NSDate *)value;

@end
