//
//  RETableViewNumberCell.h
//  Meungry
//
//  Created by Roman Efimov on 3/5/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewCell.h"
#import "REFormattedNumberField.h"
#import "RENumberItem.h"

@interface RETableViewNumberCell : RETableViewCell <UITextFieldDelegate> {
    UISegmentedControl *_prevNext;
}

@property (strong, nonatomic) RENumberItem *item;
@property (strong, nonatomic) REFormattedNumberField *textField;
@property (assign, nonatomic) CGSize textFieldPositionOffset;

- (UIToolbar *)actionBar;

@end
