//
//  REMultipleChoiceItem.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/12/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewItem.h"

@interface REMultipleChoiceItem : RETableViewItem

@property (strong, readwrite, nonatomic) NSArray *value;

+ (id)itemWithTitle:(NSString *)title value:(NSArray *)value selectionHandler:(void(^)(REMultipleChoiceItem *item))selectionHandler;
- (id)initWithTitle:(NSString *)title value:(NSArray *)value selectionHandler:(void(^)(REMultipleChoiceItem *item))selectionHandler;

@end
