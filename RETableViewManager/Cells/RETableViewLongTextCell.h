//
//  RELongTextCell.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/11/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewCell.h"
#import "RELongTextItem.h"
#import "REPlaceholderTextView.h"

@interface RETableViewLongTextCell : RETableViewCell <UITextViewDelegate>

@property (strong, readwrite, nonatomic) RELongTextItem *item;
@property (strong, readwrite, nonatomic) REPlaceholderTextView *textView;

@end
