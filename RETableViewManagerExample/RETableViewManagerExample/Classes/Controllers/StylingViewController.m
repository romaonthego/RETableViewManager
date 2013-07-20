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
    self.title = @"Styling";
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.967 green:1.000 blue:0.974 alpha:1.000];
    
    self.manager.delegate = self;
    
	[self.manager.style setBackgroundImage:[[UIImage imageNamed:@"First"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forCellType:RETableViewCellTypeFirst];
    [self.manager.style setBackgroundImage:[[UIImage imageNamed:@"Middle"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forCellType:RETableViewCellTypeMiddle];
    [self.manager.style setBackgroundImage:[[UIImage imageNamed:@"Last"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forCellType:RETableViewCellTypeLast];
    [self.manager.style setBackgroundImage:[[UIImage imageNamed:@"Single"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forCellType:RETableViewCellTypeSingle];
    
    [self.manager.style setSelectedBackgroundImage:[[UIImage imageNamed:@"First_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forCellType:RETableViewCellTypeFirst];
    [self.manager.style setSelectedBackgroundImage:[[UIImage imageNamed:@"Middle_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forCellType:RETableViewCellTypeMiddle];
    [self.manager.style setSelectedBackgroundImage:[[UIImage imageNamed:@"Last_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forCellType:RETableViewCellTypeLast];
    [self.manager.style setSelectedBackgroundImage:[[UIImage imageNamed:@"Single_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forCellType:RETableViewCellTypeSingle];
    self.manager.style.cellHeight = 42.0;
    self.manager.style.textFieldFont = [UIFont fontWithName:@"Avenir-Book" size:16];
   
    // Retain legacy grouped cell style in iOS [redacted]
    //
    if (REDeviceSystemMajorVersion() >= 7) {
        self.manager.style.contentViewMargin = 10;
        self.manager.style.backgroundImageMargin = 10;
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
}

@end
