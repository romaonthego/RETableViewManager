//
//  XIBTestCell.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 8/11/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "XIBTestCell.h"

@implementation XIBTestCell

- (void)cellWillAppear
{
    [super cellWillAppear];
    self.textLabel.text = @"";
    self.testLabel.text = self.testItem.title;
}

@end
