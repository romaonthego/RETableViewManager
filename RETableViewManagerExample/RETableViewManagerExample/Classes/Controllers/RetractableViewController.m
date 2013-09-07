//
//  RetractableViewController.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 6/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RetractableViewController.h"

@interface RetractableViewController ()

@property (strong, readwrite, nonatomic) RETableViewManager *manager;

@end

@implementation RetractableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Retractable";
    
    // Create manager
    //
	self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView];
    
    // Add main section
    //
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    NSMutableArray *collapsedItems = [NSMutableArray array];
    NSMutableArray *expandedItems = [NSMutableArray array];
    
    RETableViewItem *showMoreItem = [RETableViewItem itemWithTitle:@"Show More" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [section replaceItemsWithItemsFromArray:expandedItems];
        [section reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    RETableViewItem *showLessItem = [RETableViewItem itemWithTitle:@"Show Less" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [section replaceItemsWithItemsFromArray:collapsedItems];
        [section reloadSectionWithAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    [collapsedItems addObjectsFromArray:@[@"Test item 1", @"Test item 2", @"Test item 3", showMoreItem]];
    [expandedItems addObjectsFromArray:@[@"Test item 1", @"Test item 2", @"Test item 3", @"Test item 4", @"Test item 5", @"Test item 6", showLessItem]];
    
    [section addItemsFromArray:collapsedItems];
}

@end
