//
//  RETableViewNumberCell.m
//  Meungry
//
//  Created by Roman Efimov on 3/5/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewNumberCell.h"
#import "RETableViewManager.h"

@implementation RETableViewNumberCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableViewManager:(RETableViewManager *)tableViewManager
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier tableViewManager:(RETableViewManager *)tableViewManager];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.backgroundColor = [UIColor clearColor];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            _textField = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(140, 0, self.frame.size.width - 160, self.frame.size.height)];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            _textField = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(160, 0, self.frame.size.width - 200, self.frame.size.height)];
        
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.inputAccessoryView = self.actionBar;
        _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_textField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        [_textField becomeFirstResponder];
    }
}

- (void)prepare
{
    [super prepare];
    
    self.textLabel.text = self.item.title;
    _textField.text = self.item.value;
    _textField.placeholder = self.item.placeholder;
    _textField.format = self.item.format;
    _textField.font = self.tableViewManager.style.textFieldFont;
    _textFieldPositionOffset = self.tableViewManager.style.textFieldPositionOffset;
    _textField.keyboardAppearance = self.item.keyboardAppearance;
}


- (UIResponder *)responder
{
    return _textField;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.item.title) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            _textField.frame = CGRectMake(140 + _textFieldPositionOffset.width, _textFieldPositionOffset.height, self.frame.size.width - 160, self.frame.size.height - _textFieldPositionOffset.height);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            _textField.frame = CGRectMake(160+ _textFieldPositionOffset.width, _textFieldPositionOffset.height, self.frame.size.width - 200, self.frame.size.height - _textFieldPositionOffset.height);
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            _textField.frame = CGRectMake(20+ _textFieldPositionOffset.width, _textFieldPositionOffset.height, self.frame.size.width - 40, self.frame.size.height - _textFieldPositionOffset.height);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            _textField.frame = CGRectMake(40+ _textFieldPositionOffset.width, _textFieldPositionOffset.height, self.frame.size.width - 80, self.frame.size.height - _textFieldPositionOffset.height);
    }
}

#pragma mark -
#pragma mark UISwitch events

- (void)textFieldDidChange:(UITextField *)textField
{
    self.item.value = textField.text;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self refreshActionBar];
    [self.parentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.row inSection:self.sectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSIndexPath *indexPath = [self indexPathForNextResponder];
    if (!indexPath) {
        [self endEditing:YES];
        return YES;
    }
    RETableViewCell *cell = (RETableViewCell *)[self.parentTableView cellForRowAtIndexPath:indexPath];
    [cell.responder becomeFirstResponder];
    return YES;
}

@end
