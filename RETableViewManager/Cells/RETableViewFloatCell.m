//
//  RETableViewFloatCell.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/5/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewFloatCell.h"

@implementation RETableViewFloatCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    
    _sliderView = [[UISlider alloc] init];
    [_sliderView addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    self.accessoryView = _sliderView;
}

- (void)cellWillAppear
{
    self.textLabel.text = self.item.title;
    _sliderView.value = self.item.value;
    _sliderView.frame = CGRectMake(0.0, 0.0, self.item.sliderWidth, 10.0);
}

#pragma mark -
#pragma mark UISwitch events

- (void)sliderValueDidChange:(UISlider *)slider
{
    self.item.value = slider.value;
    if (self.item.actionBlock)
        self.item.actionBlock(self.item);
}

@end
