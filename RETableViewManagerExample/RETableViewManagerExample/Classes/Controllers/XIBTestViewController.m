//
//  XIBTestViewController.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 8/11/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "XIBTestViewController.h"
#import "XIBTestItem.h"

@interface XIBTestViewController ()

@end

@implementation XIBTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"XIB Support";
    
    // Create manager
    //
    _manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    
    // Register XIB file
    //
    [self.tableView registerNib:[UINib nibWithNibName:@"XIBTestCell" bundle:nil] forCellReuseIdentifier:@"XIBTestItem"];
    
    // Map item to a cell
    //
    _manager[@"XIBTestItem"] = @"XIBTestCell";
    
    // Add a section
    //
    RETableViewSection *section = [RETableViewSection section];
    [_manager addSection:section];
    
    for (NSInteger i = 1; i < 100; i++) {
        NSString *title = [NSString stringWithFormat:@"Item %i", i];
        XIBTestItem *item = [XIBTestItem itemWithTitle:title
                                         accessoryType:UITableViewCellAccessoryNone
                                      selectionHandler:^(RETableViewItem *item) {
            [item deselectRowAnimated:YES];
        }];
        item.cellIdentifier = @"XIBTestItem";
        [section addItem:item];
    }
}

@end
