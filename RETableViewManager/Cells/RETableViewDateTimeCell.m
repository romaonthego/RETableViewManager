//
//  RETableViewDateTimeCell.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/5/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewDateTimeCell.h"

@implementation RETableViewDateTimeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.textLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)cellDidLoad
{
    [super cellDidLoad];

}

- (void)cellWillAppear
{
    self.textLabel.text = self.item.title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textField.frame = CGRectNull;
    self.textField.alpha = 0;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    
}

@end
