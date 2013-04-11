//
//  RELongTextCell.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/11/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewLongTextCell.h"
#import "RETableViewManager.h"

@implementation RETableViewLongTextCell

+ (BOOL)canFocus
{
    return YES;
}

#pragma mark -
#pragma mark Lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    
    _textView = [[REPlaceholderTextView alloc] initWithFrame:CGRectNull];
    
    _textView.inputAccessoryView = self.actionBar;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.delegate = self;
    [self.contentView addSubview:_textView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        [_textView becomeFirstResponder];
    }
}

- (void)cellWillAppear
{
    [super cellWillAppear];

    _textView.frame = CGRectMake(self.contentView.frame.origin.x + 2, self.contentView.frame.origin.y + 2, self.contentView.frame.size.width - 4, self.contentView.frame.size.height - 4);
    _textView.text = self.item.value;
    _textView.placeholder = self.item.placeholder;
    _textView.font = self.tableViewManager.style.textFieldFont;
    _textView.autocapitalizationType = self.item.autocapitalizationType;
    _textView.autocorrectionType = self.item.autocorrectionType;
    _textView.spellCheckingType = self.item.spellCheckingType;
    _textView.keyboardType = self.item.keyboardType;
    _textView.keyboardAppearance = self.item.keyboardAppearance;
    _textView.returnKeyType = self.item.returnKeyType;
    _textView.enablesReturnKeyAutomatically = self.item.enablesReturnKeyAutomatically;
    _textView.secureTextEntry = self.item.secureTextEntry;
}

- (UIResponder *)responder
{
    return _textView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    /*CGFloat cellOffset = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 10 : 60;
    //CGFloat fieldOffset = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 10 : 40;
    //CGFloat width = 0;
    CGRect frame = CGRectMake(0, self.tableViewManager.style.textFieldPositionOffset.height, 10, self.frame.size.height - self.tableViewManager.style.textFieldPositionOffset.height);
    frame.origin.x = cellOffset + self.tableViewManager.style.textFieldPositionOffset.width;
    frame.size.width = self.frame.size.width - frame.origin.x - cellOffset;
    _textView.frame = frame;*/
}

#pragma mark -
#pragma mark UITextView delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self updateActionBarNavigationControl];
    [self.parentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.row inSection:self.sectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return YES;
}

@end
