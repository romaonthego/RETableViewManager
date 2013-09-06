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
#import "EditingViewController.h"
#import "RetractableViewController.h"
#import "StylingViewController.h"
#import "XIBTestViewController.h"
#import "IndexedListViewController.h"
#import "ValidationsViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"RETableViewManager";
    __typeof (&*self) __weak weakSelf = self;
	
    // Create manager
    //
    _manager = [[RETableViewManager alloc] initWithTableView:self.tableView];
    _manager.delegate = self;
    
    // Add sections and items
    //
    RETableViewSection *section = [RETableViewSection section];
    [_manager addSection:section];
    
    [section addItem:[RETableViewItem itemWithTitle:@"Forms" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES]; // same as [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        [weakSelf.navigationController pushViewController:[[ControlsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
    }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"List" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        [weakSelf.navigationController pushViewController:[[ListViewController alloc] initWithStyle:UITableViewStylePlain] animated:YES];
    }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"Editing" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        [weakSelf.navigationController pushViewController:[[EditingViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
    }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"Retractable" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        [weakSelf.navigationController pushViewController:[[RetractableViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
    }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"Styling" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        [weakSelf.navigationController pushViewController:[[StylingViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
    }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"Interface Builder Support" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        [weakSelf.navigationController pushViewController:[[XIBTestViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
    }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"Indexed List" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        [weakSelf.navigationController pushViewController:[[IndexedListViewController alloc] initWithStyle:UITableViewStylePlain] animated:YES];
    }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"Validations" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        [weakSelf.navigationController pushViewController:[[ValidationsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
    }]];
}

@end
