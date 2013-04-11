//
//  REPlaceholderTextView.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/11/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface REPlaceholderTextView : UITextView

@property (strong, readonly, nonatomic) UILabel *placeHolderLabel;
@property (copy, readwrite, nonatomic) NSString *placeholder;
@property (strong, readwrite, nonatomic) UIColor *placeholderColor;

- (void)textChanged:(NSNotification*)notification;

@end
