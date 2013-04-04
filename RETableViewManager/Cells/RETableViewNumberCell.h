//
//  RETableViewNumberCell.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewTextCell.h"
#import "REFormattedNumberField.h"
#import "RENumberItem.h"

@interface RETableViewNumberCell : RETableViewTextCell

@property (strong, readwrite, nonatomic) RENumberItem *item;
@property (strong, readwrite, nonatomic) REFormattedNumberField *textField;

@end
