//
// RECreditCardItem.h
// RETableViewManager
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "RETableViewItem.h"

typedef NS_ENUM(NSUInteger, RECreditCardType) {
    RECreditCardTypeUnknown,
    RECreditCardTypeVisa,
    RECreditCardTypeMasterCard,
    RECreditCardTypeAmex,
    RECreditCardTypeDiscover
};


@interface RECreditCardItem : RETableViewItem

// Appearance customization
//
@property (strong, readwrite, nonatomic) UIImage *expiredRibbonImage;

// Data and values
//
@property (copy, readwrite, nonatomic) NSString *number;
@property (copy, readwrite, nonatomic) NSString *expirationDate;
@property (copy, readwrite, nonatomic) NSString *cvv;

@property (assign, readwrite, nonatomic) RECreditCardType creditCardType;

@property (assign, readwrite, nonatomic) BOOL cvvRequired;

// Keyboard
//
@property (assign, readwrite, nonatomic) UIKeyboardAppearance keyboardAppearance;             // default is UIKeyboardAppearanceDefault

+ (instancetype)itemWithNumber:(NSString *)number expirationDate:(NSDate *)expiration cvv:(NSString *)cvv;
+ (instancetype)itemWithNumber:(NSString *)number expirationString:(NSString *)expirationDate cvv:(NSString *)cvv;

- (id)initWithNumber:(NSString *)number expirationDate:(NSString *)expirationDate cvv:(NSString *)cvv;

@end
