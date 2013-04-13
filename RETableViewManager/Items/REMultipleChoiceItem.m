//
//  REMultipleChoiceItem.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/12/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "REMultipleChoiceItem.h"

@implementation REMultipleChoiceItem

+ (id)itemWithTitle:(NSString *)title value:(NSArray *)value selectionHandler:(void(^)(REMultipleChoiceItem *item))selectionHandler
{
    return [[self alloc] initWithTitle:title value:value selectionHandler:selectionHandler];
}

- (id)initWithTitle:(NSString *)title value:(NSArray *)value selectionHandler:(void(^)(REMultipleChoiceItem *item))selectionHandler
{
    self = [super init];
    if (!self)
        return nil;
    
    self.title = title;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionHandler = selectionHandler;
    self.value = value;
    self.cellStyle = UITableViewCellStyleValue1;
    
    return self;
}

- (void)setValue:(NSArray *)value
{
    _value = value;
    
    if (value.count == 0)
        self.detailLabelText = @"";
    
    if (value.count == 1)
        self.detailLabelText = [value objectAtIndex:0];
    
    if (value.count > 1)
        self.detailLabelText = [NSString stringWithFormat:NSLocalizedString(@"%i selected", @"%i selected"), value.count];
}

@end
