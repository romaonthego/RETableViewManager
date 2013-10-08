//
// REFormattedNumberField.m
// REFormattedNumberField
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

#import "REFormattedNumberField.h"

@interface REFormattedNumberField ()

@property (copy, readwrite, nonatomic) NSString *currentFormattedText;

@end

@implementation REFormattedNumberField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:(CGRect)frame];
    if (self) {
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.format = @"X";
        [self addTarget:self action:@selector(formatInput:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.keyboardType = UIKeyboardTypeNumberPad;
    self.format = @"X";
    [self addTarget:self action:@selector(formatInput:) forControlEvents:UIControlEventEditingChanged];
}

- (NSString *)string:(NSString *)string withNumberFormat:(NSString *)format
{
    if (!string)
        return @"";
    
    return [string re_stringWithNumberFormat:format];
}

- (void)formatInput:(UITextField *)textField
{
    // If it was not deleteBackward event
    //
    if (![textField.text isEqualToString:self.currentFormattedText]) {
        __typeof (self) __weak weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __typeof (self) __strong strongSelf = weakSelf;
            textField.text = [strongSelf.unformattedText re_stringWithNumberFormat:strongSelf.format];
            strongSelf.currentFormattedText = textField.text;
        });
    }
}

- (void)deleteBackward
{
    NSInteger decimalPosition = -1;
    for (NSInteger i = self.text.length - 1; i > 0; i--) {
        NSString *c = [self.text substringWithRange:NSMakeRange(i - 1, 1)];
        
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:c];
        valid = [alphaNums isSupersetOfSet:inStringSet];
        if (valid) {
            decimalPosition = i;
            break;
        }
    }
    
    if (decimalPosition == -1) {
        self.text = @"";
    } else {
        self.text = [self.text substringWithRange:NSMakeRange(0, decimalPosition)];
    }
    
    self.currentFormattedText = self.text;
    
    //Since iOS6 the UIControlEventEditingChanged is not triggered by programmatically changing the text property of UITextField.
    //
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
}

- (NSString *)unformattedText
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\D" options:NSRegularExpressionCaseInsensitive error:NULL];
    return [regex stringByReplacingMatchesInString:self.text options:0 range:NSMakeRange(0, self.text.length) withTemplate:@""];
}

@end
