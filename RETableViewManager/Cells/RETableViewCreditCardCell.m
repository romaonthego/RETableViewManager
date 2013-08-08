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
    
    _creditCardImageViewContainer = [[UIView alloc] init];
    [self.contentView addSubview:_creditCardImageViewContainer];
    
    _creditCardStackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    _creditCardStackImageView.image = [UIImage imageNamed:@"RETableViewManager.bundle/Card_Stack"];
    _creditCardStackImageView.tag = 0;
    _currentImageView = _creditCardStackImageView;
    [_creditCardImageViewContainer addSubview:_creditCardStackImageView];
    
    _creditCardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    _creditCardImageView.image = [UIImage imageNamed:@"RETableViewManager.bundle/Card_Visa"];
    _creditCardImageView.tag = 1;
    
    _creditCardBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    _creditCardBackImageView.image = [UIImage imageNamed:@"RETableViewManager.bundle/Card_Back"];
    _creditCardBackImageView.tag = 2;
    
    _wrapperView = [[UIView alloc] initWithFrame:CGRectMake(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 60 : 60 + _textFieldPositionOffset.width, _textFieldPositionOffset.height, self.frame.size.width - 70, self.frame.size.height)];
    _wrapperView.clipsToBounds = YES;
    [self.contentView addSubview:_wrapperView];
    
    _creditCardField = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(0, 0, 216, self.frame.size.height - _textFieldPositionOffset.height)];
    _creditCardField.tag = 0;
    _creditCardField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _creditCardField.inputAccessoryView = self.actionBar;
    _creditCardField.delegate = self;
    _creditCardField.placeholder = @"1234 1234 1234 1234";
    _creditCardField.format = @"XXXX XXXX XXXX XXXX";
    [_creditCardField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_wrapperView addSubview:_creditCardField];
    
    
    _expirationDateField = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(320, 0, 80, self.frame.size.height)];
    _expirationDateField.tag = 1;
    _expirationDateField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _expirationDateField.inputAccessoryView = self.actionBar;
    _expirationDateField.format = @"XX/XX";
    _expirationDateField.placeholder = @"MM/YY";
    _expirationDateField.delegate = self;
    [_expirationDateField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_wrapperView addSubview:_expirationDateField];
    
    _cvvField = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(320, 0, 60, self.frame.size.height)];
    _cvvField.tag = 2;
    _cvvField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _cvvField.inputAccessoryView = self.actionBar;
    _cvvField.format = @"XXX";
    _cvvField.placeholder = @"CVV";
    _cvvField.delegate = self;
    [_cvvField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_wrapperView addSubview:_cvvField];
}

- (void)cellWillAppear
{
    CGFloat cellOffset = 10.0;
    
    if (REDeviceIsUIKit7() && self.section.style.contentViewMargin <= 0)
        cellOffset += 5.0;
    _creditCardImageViewContainer.frame = CGRectMake(cellOffset, 5, 32, 32);
    
    
    self.textLabel.text = self.item.title;
    
    _creditCardField.text = self.item.number;
    _creditCardField.font = [UIFont systemFontOfSize:17];
    _creditCardField.keyboardAppearance = self.item.keyboardAppearance;
    
    _expirationDateField.text = self.item.expirationDate;
    _expirationDateField.font = [UIFont systemFontOfSize:17];
    _expirationDateField.keyboardAppearance = self.item.keyboardAppearance;
    
    _cvvField.text = self.item.cvv;
    _cvvField.font = [UIFont systemFontOfSize:17];
    _cvvField.keyboardAppearance = self.item.keyboardAppearance;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_creditCardField sizeToFit];
    [_expirationDateField sizeToFit];
    [_cvvField sizeToFit];
    
    CGRect frame = _creditCardField.frame;
    frame.size.width += UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 30 : 50;
    frame.size.height = self.contentView.frame.size.height;
    _creditCardField.frame = frame;
    
    frame = _expirationDateField.frame;
    frame.size.width += UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 30 : 50;
    frame.size.height = self.contentView.frame.size.height;
    _expirationDateField.frame = frame;
    
    frame = _cvvField.frame;
    frame.size.width += UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 30 : 50;
    frame.size.height = self.contentView.frame.size.height;
    _cvvField.frame = frame;
    
    if ([self.tableViewManager.delegate respondsToSelector:@selector(tableView:willLayoutCellSubviews:forRowAtIndexPath:)])
        [self.tableViewManager.delegate tableView:self.tableViewManager.tableView willLayoutCellSubviews:self forRowAtIndexPath:[(UITableView *)self.superview indexPathForCell:self]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        [_creditCardField becomeFirstResponder];
    }
}

- (UIResponder *)responder
{
    return _creditCardField;
}

- (void)flipCreditCardImageViewBack:(UITextField *)textField
{
    if ((textField.tag == 1 || textField.tag == 2) && !_cvvField.isFirstResponder) {
        [UIView transitionFromView:_creditCardBackImageView toView:_currentImageView duration:0.4 options:UIViewAnimationOptionTransitionFlipFromRight completion:nil];
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
        _creditCardImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"RETableViewManager.bundle/Card_%@", issuer]];
        [UIView transitionFromView:_creditCardStackImageView toView:_creditCardImageView duration:0.4 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
        _currentImageView = _creditCardImageView;
    } else {
        if (_currentImageView != _creditCardStackImageView) {
            [UIView transitionFromView:_creditCardImageView toView:_creditCardStackImageView duration:0.4 options:UIViewAnimationOptionTransitionFlipFromRight completion:nil];
            _currentImageView = _creditCardStackImageView;
        }
    }
    
    BOOL isAmex = [issuer isEqualToString:@"Amex"];
    
    if (textField.tag == 0 && textField.text.length == (isAmex ? 18 : 19) ) {
        [_expirationDateField becomeFirstResponder];
        __typeof(&*self) __weak weakSelf = self;
        [UIView animateWithDuration:0.1 animations:^{
            
            NSString *substring = [textField.text substringToIndex:textField.text.length - (isAmex ? 3 : 4)];
            CGSize size = [substring sizeWithFont:textField.font];
            weakSelf.creditCardField.frame = CGRectMake(-size.width, weakSelf.creditCardField.frame.origin.y, weakSelf.creditCardField.frame.size.width, weakSelf.creditCardField.frame.size.height);
            weakSelf.expirationDateField.frame = CGRectMake(CGRectGetMaxX(_creditCardField.frame), weakSelf.expirationDateField.frame.origin.y, weakSelf.expirationDateField.frame.size.width, weakSelf.expirationDateField.frame.size.height);
            weakSelf.cvvField.frame = CGRectMake(CGRectGetMaxX(_expirationDateField.frame), weakSelf.cvvField.frame.origin.y, weakSelf.cvvField.frame.size.width, weakSelf.cvvField.frame.size.height);
        }];
    }
    
    if (textField.tag == 0 && textField.text.length == (isAmex ? 17 : 18)) {
        if (textField.tag == 0) {
            __typeof(&*self) __weak weakSelf = self;
            [UIView animateWithDuration:0.1 animations:^{
                weakSelf.creditCardField.frame = CGRectMake(0, weakSelf.creditCardField.frame.origin.y, weakSelf.creditCardField.frame.size.width, weakSelf.creditCardField.frame.size.height);
                weakSelf.expirationDateField.frame = CGRectMake(320, weakSelf.expirationDateField.frame.origin.y, weakSelf.expirationDateField.frame.size.width, weakSelf.expirationDateField.frame.size.height);
                weakSelf.cvvField.frame = CGRectMake(320, weakSelf.cvvField.frame.origin.y, weakSelf.cvvField.frame.size.width, weakSelf.cvvField.frame.size.height);
            }];
        }
    }
    
    if (textField.tag == 1 && textField.text.length == 5) {
        [_cvvField becomeFirstResponder];
    }
}

#pragma mark - 
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self updateActionBarNavigationControl];
    if (textField.tag == 0) {
        [UIView transitionFromView:_creditCardBackImageView toView:_currentImageView duration:0.4 options:UIViewAnimationOptionTransitionFlipFromRight completion:nil];
    }
    if (textField.tag == 2) {
        [UIView transitionFromView:_currentImageView toView:_creditCardBackImageView duration:0.4 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self performSelector:@selector(flipCreditCardImageViewBack:) withObject:textField afterDelay:0.1];
    return YES;
}

@end
