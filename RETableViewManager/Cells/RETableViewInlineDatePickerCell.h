//
//  RETableViewInlineDatePickerCell.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 10/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewCell.h"
#import "REInlineDatePickerItem.h"

@interface RETableViewInlineDatePickerCell : RETableViewCell

@property (strong, readwrite, nonatomic) REInlineDatePickerItem *item;

@end
