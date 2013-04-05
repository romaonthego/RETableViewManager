//
//  RETableViewDateTimeCell.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/5/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewTextCell.h"
#import "REDateTimeItem.h"

@interface RETableViewDateTimeCell : RETableViewCell <UITextFieldDelegate>

@property (strong, readwrite, nonatomic) UITextField *textField;
@property (strong, readonly, nonatomic) UIDatePicker *datePicker;
@property (strong, readonly, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, readwrite, nonatomic) REDateTimeItem *item;

@end
