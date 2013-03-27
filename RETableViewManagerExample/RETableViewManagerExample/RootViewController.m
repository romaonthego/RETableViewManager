//
//  RootViewController.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 2/28/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"
#import "ControlsViewController.h"
#import "ListViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"RETableViewManager";
    RootViewController __weak *weakSelf = self;
	
    // Create manager
    //
    _manager = [[RETableViewManager alloc] init];
    _manager.delegate = self;
    
    RETableViewSection *section = [[RETableViewSection alloc] init];
    [_manager addSection:section];
    
    [section addItem:[REStringItem itemWithTitle:@"Forms" accessoryType:UITableViewCellAccessoryDisclosureIndicator actionBlock:^(RETableViewItem *item) {
        [weakSelf.navigationController pushViewController:[[ControlsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
    }]];
    
    [section addItem:[REStringItem itemWithTitle:@"List" accessoryType:UITableViewCellAccessoryDisclosureIndicator actionBlock:^(RETableViewItem *item) {
        [weakSelf.navigationController pushViewController:[[ListViewController alloc] initWithStyle:UITableViewStylePlain] animated:YES];
    }]];
    
    // Set delegate and datasource
    //
    self.tableView.dataSource = _manager;
    self.tableView.delegate =  _manager;
}

#pragma mark -
#pragma mark RETableViewManagerDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
