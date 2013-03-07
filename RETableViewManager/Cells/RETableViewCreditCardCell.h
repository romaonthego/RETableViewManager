//
//  RETableViewCreditCardCell.h
//  Meungry
//
//  Created by Roman Efimov on 3/7/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewCell.h"
#import "REFormattedNumberField.h"
#import "RECreditCardItem.h"

@interface RETableViewCreditCardCell : RETableViewCell <UITextFieldDelegate> {
    UIView *_wrapperView;
}

@property (strong, nonatomic) RECreditCardItem *item;
@property (strong, nonatomic) REFormattedNumberField *creditCardField;
@property (strong, nonatomic) REFormattedNumberField *expirationDateField;
@property (strong, nonatomic) REFormattedNumberField *cvvField;
@property (assign, nonatomic) CGSize textFieldPositionOffset;
@property (strong, nonatomic) UIImageView *ccImageView;


@end
