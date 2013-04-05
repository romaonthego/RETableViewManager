//
//  RETableViewFloatCell.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/5/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewCell.h"
#import "REFloatItem.h"

@interface RETableViewFloatCell : RETableViewCell

@property (strong, readonly, nonatomic) UISlider *sliderView;
@property (strong, readwrite, nonatomic) REFloatItem *item;

@end
