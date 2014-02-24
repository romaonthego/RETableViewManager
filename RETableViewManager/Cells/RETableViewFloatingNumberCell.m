//
//  RETableViewFloatingNumberCell.m
//  RETableViewManagerExample
//
//  Created by huang eleven on 1/22/14.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import "RETableViewFloatingNumberCell.h"

@interface RETableViewFloatingNumberCell()

@property (strong, nonatomic) NSString *oldTextValue;

@end

@implementation RETableViewFloatingNumberCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    self.textField.keyboardType = UIKeyboardTypeDecimalPad;
}


#pragma mark -- textfield delegate

- (void)textFieldDidChange:(REFormattedNumberField *)textField
{
    NSString *value = textField.text;
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[-+]?[0-9]+\\.?[0-9]*$" options:0 error:&error];
    
    NSRange range = [regex rangeOfFirstMatchInString:value options:0 range:NSMakeRange(0, value.length)];
    
    if (range.length != value.length) {
        textField.text = _oldTextValue;
    } else {
        _oldTextValue = value;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *value = textField.text;
    
    if (value && [value characterAtIndex:(value.length - 1)] == '.') {
        textField.text = [NSString stringWithFormat:@"%@0", value];
        _oldTextValue = textField.text;
    }
}

@end
