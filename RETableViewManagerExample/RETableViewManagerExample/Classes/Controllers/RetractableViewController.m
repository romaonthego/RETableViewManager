//
//  RetractableViewController.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 6/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RetractableViewController.h"

@interface RetractableViewController ()

@end

@implementation RetractableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	_manager = [[RETableViewManager alloc] initWithTableView:self.tableView];
    _section = [RETableViewSection section];
    [_manager addSection:_section];
    
    [_section addItem:@"Test item 1"];
    [_section addItem:@"Test item 2"];
    [_section addItem:@"Test item 3"];
    
    
}

@end
