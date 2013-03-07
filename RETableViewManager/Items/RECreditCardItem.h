//
//  RECreditCardItem.h
//  Meungry
//
//  Created by Roman Efimov on 3/7/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewItem.h"

@interface RECreditCardItem : RETableViewItem

// Data and values
//
@property (copy, nonatomic) NSString *number;
@property (copy, nonatomic) NSString *expirationDate;
@property (copy, nonatomic) NSString *cvv;

// Keyboard
//
@property (nonatomic) UIKeyboardAppearance keyboardAppearance;             // default is UIKeyboardAppearanceDefault

+ (id)item;
+ (id)itemWithNumber:(NSString *)number expirationDate:(NSString *)expirationDate cvv:(NSString *)cvv;
- (id)initWithNumber:(NSString *)number expirationDate:(NSString *)expirationDate cvv:(NSString *)cvv;

@end
