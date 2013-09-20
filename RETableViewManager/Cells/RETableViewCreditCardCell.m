//
// RETableViewCreditCardCell.m
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

#import "RETableViewCreditCardCell.h"
#import "RETableViewManager.h"
#import "NSString+RETableViewManagerAdditions.h"

@interface RETableViewCreditCardCell ()

@property (strong, readwrite, nonatomic) UIView *wrapperView;
@property (strong, readwrite, nonatomic) UIView *creditCardImageViewContainer;
@property (strong, readwrite, nonatomic) UIImageView *currentImageView;
@property (strong, readwrite, nonatomic) UIImageView *creditCardBackImageView;
@property (strong, readwrite, nonatomic) UIImageView *creditCardImageView;
@property (strong, readwrite, nonatomic) UIImageView *creditCardStackImageView;
@property (strong, readwrite, nonatomic) REFormattedNumberField *creditCardField;
@property (strong, readwrite, nonatomic) REFormattedNumberField *expirationDateField;
@property (strong, readwrite, nonatomic) REFormattedNumberField *cvvField;

@end

@implementation RETableViewCreditCardCell

static inline NSString * RECreditCardType(NSString *creditCardNumber)
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\D" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSString *strippedNumber = [regex stringByReplacingMatchesInString:creditCardNumber options:0 range:NSMakeRange(0, creditCardNumber.length) withTemplate:@""];
    
    NSDictionary *types = @{@"Visa": @"^4[0-9]{12}(?:[0-9]{2})?",
                            @"MasterCard": @"^5[1-5][0-9]{13}",
                            @"Amex": @"^3[47][0-9]{12}",
                            @"Discover": @"^6(?:011|5[0-9]{2})[0-9]{11}"};
    
    for (NSString *type in types) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:[types objectForKey:type] options:NSRegularExpressionCaseInsensitive error:NULL];
        if ([regex numberOfMatchesInString:strippedNumber options:0 range:NSMakeRange(0, strippedNumber.length)] == 1)
            return type;
    }
    return nil;
}

+ (BOOL)canFocus
{
    return YES;
}

#pragma mark -
#pragma mark Lifecycle

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    self.creditCardImageViewContainer = [[UIView alloc] init];
    [self.contentView addSubview:self.creditCardImageViewContainer];
    
    self.creditCardStackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    self.creditCardStackImageView.image = [UIImage imageNamed:@"RETableViewManager.bundle/Card_Stack"];
    self.creditCardStackImageView.tag = 0;
    self.currentImageView = self.creditCardStackImageView;
    [self.creditCardImageViewContainer addSubview:self.creditCardStackImageView];
    
    self.creditCardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    self.creditCardImageView.image = [UIImage imageNamed:@"RETableViewManager.bundle/Card_Visa"];
    self.creditCardImageView.tag = 1;
    
    self.creditCardBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    self.creditCardBackImageView.image = [UIImage imageNamed:@"RETableViewManager.bundle/Card_Back"];
    self.creditCardBackImageView.tag = 2;
    
    self.wrapperView = [[UIView alloc] initWithFrame:CGRectMake(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 60 : 60 + self.textFieldPositionOffset.width, self.textFieldPositionOffset.height, self.frame.size.width - 70, self.frame.size.height)];
    self.wrapperView.clipsToBounds = YES;
    [self.contentView addSubview:self.wrapperView];
    
    self.creditCardField = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(0, 0, 216, self.frame.size.height - self.textFieldPositionOffset.height)];
    self.creditCardField.tag = 0;
    self.creditCardField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.creditCardField.inputAccessoryView = self.actionBar;
    self.creditCardField.delegate = self;
    self.creditCardField.placeholder = @"1234 1234 1234 1234";
    self.creditCardField.format = @"XXXX XXXX XXXX XXXX";
    [self.creditCardField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.wrapperView addSubview:self.creditCardField];
    
    
    self.expirationDateField = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(320, 0, 80, self.frame.size.height)];
    self.expirationDateField.tag = 1;
    self.expirationDateField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.expirationDateField.inputAccessoryView = self.actionBar;
    self.expirationDateField.format = @"XX/XX";
    self.expirationDateField.placeholder = @"MM/YY";
    self.expirationDateField.delegate = self;
    [self.expirationDateField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.wrapperView addSubview:self.expirationDateField];
    
    self.cvvField = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(320, 0, 60, self.frame.size.height)];
    self.cvvField.tag = 2;
    self.cvvField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.cvvField.inputAccessoryView = self.actionBar;
    self.cvvField.format = @"XXX";
    self.cvvField.placeholder = @"CVV";
    self.cvvField.delegate = self;
    [self.cvvField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.wrapperView addSubview:self.cvvField];
}

- (void)cellWillAppear
{
    CGFloat cellOffset = 10.0;
    
    if (REUIKitIsFlatMode() && self.section.style.contentViewMargin <= 0)
        cellOffset += 5.0;
    self.creditCardImageViewContainer.frame = CGRectMake(cellOffset, 5, 32, 32);
    
    
    self.textLabel.text = self.item.title;
    
    self.creditCardField.text = self.item.number;
    self.creditCardField.font = [UIFont systemFontOfSize:17];
    self.creditCardField.keyboardAppearance = self.item.keyboardAppearance;
    
    self.expirationDateField.text = self.item.expirationDate;
    self.expirationDateField.font = [UIFont systemFontOfSize:17];
    self.expirationDateField.keyboardAppearance = self.item.keyboardAppearance;
    
    self.cvvField.text = self.item.cvv;
    self.cvvField.font = [UIFont systemFontOfSize:17];
    self.cvvField.keyboardAppearance = self.item.keyboardAppearance;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.creditCardField sizeToFit];
    [self.expirationDateField sizeToFit];
    [self.cvvField sizeToFit];
    
    CGRect frame = self.creditCardField.frame;
    frame.size.width += UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 30 : 50;
    frame.size.height = self.contentView.frame.size.height;
    self.creditCardField.frame = frame;
    
    frame = self.expirationDateField.frame;
    frame.size.width += UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 30 : 50;
    frame.size.height = self.contentView.frame.size.height;
    self.expirationDateField.frame = frame;
    
    frame = self.cvvField.frame;
    frame.size.width += UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 30 : 50;
    frame.size.height = self.contentView.frame.size.height;
    self.cvvField.frame = frame;
    
    if ([self.tableViewManager.delegate respondsToSelector:@selector(tableView:willLayoutCellSubviews:forRowAtIndexPath:)])
        [self.tableViewManager.delegate tableView:self.tableViewManager.tableView willLayoutCellSubviews:self forRowAtIndexPath:[self.tableViewManager.tableView indexPathForCell:self]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        [self.creditCardField becomeFirstResponder];
    }
}

- (UIResponder *)responder
{
    return self.creditCardField;
}

- (void)flipCreditCardImageViewBack:(UITextField *)textField
{
    if ((textField.tag == 1 || textField.tag == 2) && !self.cvvField.isFirstResponder) {
        [UIView transitionFromView:self.creditCardBackImageView toView:self.currentImageView duration:0.4 options:UIViewAnimationOptionTransitionFlipFromRight completion:nil];
    }
}

#pragma mark -
#pragma mark Handle events

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.tag == 0) self.item.number = textField.text;
    if (textField.tag == 1) self.item.expirationDate = textField.text;
    if (textField.tag == 2) self.item.cvv = textField.text;
    
    
    NSString *issuer = RECreditCardType(self.item.number);
    if (issuer) {
        self.creditCardImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"RETableViewManager.bundle/Card_%@", issuer]];
        [UIView transitionFromView:self.creditCardStackImageView toView:self.creditCardImageView duration:0.4 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
        self.currentImageView = self.creditCardImageView;
    } else {
        if (self.currentImageView != self.creditCardStackImageView) {
            [UIView transitionFromView:self.creditCardImageView toView:self.creditCardStackImageView duration:0.4 options:UIViewAnimationOptionTransitionFlipFromRight completion:nil];
            self.currentImageView = self.creditCardStackImageView;
        }
    }
    
    BOOL isAmex = [issuer isEqualToString:@"Amex"];
    
    if (textField.tag == 0 && textField.text.length == (isAmex ? 18 : 19) ) {
        [self.expirationDateField becomeFirstResponder];
        [UIView animateWithDuration:0.1 animations:^{
            NSString *substring = [textField.text substringToIndex:textField.text.length - (isAmex ? 3 : 4)];
            CGSize size = [substring re_sizeWithFont:textField.font];
            self.creditCardField.frame = CGRectMake(-size.width, self.creditCardField.frame.origin.y, self.creditCardField.frame.size.width, self.creditCardField.frame.size.height);
            self.expirationDateField.frame = CGRectMake(CGRectGetMaxX(self.creditCardField.frame), self.expirationDateField.frame.origin.y, self.expirationDateField.frame.size.width, self.expirationDateField.frame.size.height);
            self.cvvField.frame = CGRectMake(CGRectGetMaxX(self.expirationDateField.frame), self.cvvField.frame.origin.y, self.cvvField.frame.size.width, self.cvvField.frame.size.height);
        }];
    }
    
    if (textField.tag == 0 && textField.text.length == (isAmex ? 17 : 18)) {
        if (textField.tag == 0) {
            [UIView animateWithDuration:0.1 animations:^{
                self.creditCardField.frame = CGRectMake(0, self.creditCardField.frame.origin.y, self.creditCardField.frame.size.width, self.creditCardField.frame.size.height);
                self.expirationDateField.frame = CGRectMake(320, self.expirationDateField.frame.origin.y, self.expirationDateField.frame.size.width, self.expirationDateField.frame.size.height);
                self.cvvField.frame = CGRectMake(320, self.cvvField.frame.origin.y, self.cvvField.frame.size.width, self.cvvField.frame.size.height);
            }];
        }
    }
    
    if (textField.tag == 1 && textField.text.length == 5) {
        [self.cvvField becomeFirstResponder];
    }
}

#pragma mark - 
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self updateActionBarNavigationControl];
    if (textField.tag == 0) {
        [UIView transitionFromView:self.creditCardBackImageView toView:self.currentImageView duration:0.4 options:UIViewAnimationOptionTransitionFlipFromRight completion:nil];
    }
    if (textField.tag == 2) {
        [UIView transitionFromView:self.currentImageView toView:self.creditCardBackImageView duration:0.4 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self performSelector:@selector(flipCreditCardImageViewBack:) withObject:textField afterDelay:0.1];
    return YES;
}

@end
