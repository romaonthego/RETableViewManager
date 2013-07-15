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
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\D" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSString *stripped = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:@""];
    
    NSMutableArray *patterns = [[NSMutableArray alloc] init];
    NSMutableArray *separators = [[NSMutableArray alloc] init];
    [patterns addObject:@0];
    
    NSInteger maxLength = 0;
    for (NSInteger i = 0; i < [format length]; i++) {
        NSString *character = [format substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"X"]) {
            maxLength++;
            NSNumber *number = [patterns objectAtIndex:patterns.count - 1];
            number = @(number.integerValue + 1);
            [patterns replaceObjectAtIndex:patterns.count - 1 withObject:number];
        } else {
            [patterns addObject:@0];
            [separators addObject:character];
        }
    }
    
    if (stripped.length > maxLength)
        stripped = [stripped substringToIndex:maxLength];
    
    NSString *match = @"";
    NSString *replace = @"";
    
    NSMutableArray *expressions = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < patterns.count; i++) {
        NSString *currentMatch = [match stringByAppendingString:@"(\\d+)"];
        match = [match stringByAppendingString:[NSString stringWithFormat:@"(\\d{%d})", ((NSNumber *)[patterns objectAtIndex:i]).integerValue]];
        
        NSString *template;
        if (i == 0) {
            template = [NSString stringWithFormat:@"$%i", i+1];
        } else {
            template = [NSString stringWithFormat:@"%@$%i", [separators objectAtIndex:i-1], i+1];
        }
        replace = [replace stringByAppendingString:template];
        [expressions addObject:@{@"match": currentMatch, @"replace": replace}];
    }
    
    NSString *result = [stripped copy];
    
    for (NSDictionary *exp in expressions) {
        NSString *match = [exp objectForKey:@"match"];
        NSString *replace = [exp objectForKey:@"replace"];
        NSString *modifiedString = [stripped stringByReplacingOccurrencesOfString:match
                                                                       withString:replace
                                                                          options:NSRegularExpressionSearch
                                                                            range:NSMakeRange(0, stripped.length)];
        
        if (![modifiedString isEqualToString:stripped])
            result = modifiedString;
    }
    return result;
}

- (void)formatInput:(UITextField *)textField
{
    __typeof (&*self) __weak weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        textField.text = [weakSelf string:textField.text withNumberFormat:_format];
    });
}

- (NSString *)unformattedText
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\D" options:NSRegularExpressionCaseInsensitive error:NULL];
    return [regex stringByReplacingMatchesInString:self.text options:0 range:NSMakeRange(0, self.text.length) withTemplate:@""];
}

@end
