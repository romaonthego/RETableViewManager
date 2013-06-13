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
    
	[self.manager.style setBackgroundImage:[[UIImage imageNamed:@"First"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forCellType:RETableViewCellTypeFirst];
    [self.manager.style setBackgroundImage:[[UIImage imageNamed:@"Middle"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forCellType:RETableViewCellTypeMiddle];
    [self.manager.style setBackgroundImage:[[UIImage imageNamed:@"Last"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forCellType:RETableViewCellTypeLast];
    [self.manager.style setBackgroundImage:[[UIImage imageNamed:@"Single"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forCellType:RETableViewCellTypeSingle];
    
    [self.manager.style setSelectedBackgroundImage:[[UIImage imageNamed:@"First_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forCellType:RETableViewCellTypeFirst];
    [self.manager.style setSelectedBackgroundImage:[[UIImage imageNamed:@"Middle_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forCellType:RETableViewCellTypeMiddle];
    [self.manager.style setSelectedBackgroundImage:[[UIImage imageNamed:@"Last_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forCellType:RETableViewCellTypeLast];
    [self.manager.style setSelectedBackgroundImage:[[UIImage imageNamed:@"Single_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forCellType:RETableViewCellTypeSingle];
    self.manager.style.cellHeight = 41;
}

@end
