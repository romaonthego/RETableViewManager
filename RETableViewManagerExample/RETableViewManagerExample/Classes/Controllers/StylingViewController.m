//
//  StylingViewController.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 6/13/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "StylingViewController.h"

@interface StylingViewController ()

@end

@implementation StylingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.967 green:1.000 blue:0.974 alpha:1.000];
    
	[self.manager.style setBackgroundImage:[UIImage imageNamed:@"First"] forCellType:RETableViewCellTypeFirst];
    [self.manager.style setBackgroundImage:[UIImage imageNamed:@"Middle"] forCellType:RETableViewCellTypeMiddle];
    [self.manager.style setBackgroundImage:[UIImage imageNamed:@"Last"] forCellType:RETableViewCellTypeLast];
    [self.manager.style setBackgroundImage:[UIImage imageNamed:@"Single"] forCellType:RETableViewCellTypeSingle];
    
    [self.manager.style setSelectedBackgroundImage:[UIImage imageNamed:@"First_Selected"] forCellType:RETableViewCellTypeFirst];
    [self.manager.style setSelectedBackgroundImage:[UIImage imageNamed:@"Middle_Selected"] forCellType:RETableViewCellTypeMiddle];
    [self.manager.style setSelectedBackgroundImage:[UIImage imageNamed:@"Last_Selected"] forCellType:RETableViewCellTypeLast];
    [self.manager.style setSelectedBackgroundImage:[UIImage imageNamed:@"Single_Selected"] forCellType:RETableViewCellTypeSingle];
    self.manager.style.cellHeight = 41;

}

@end
