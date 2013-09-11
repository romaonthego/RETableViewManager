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

@property (strong, readwrite, nonatomic) RETableViewManager *manager;

@end

@implementation XIBTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"XIB Support";
    
    // Create manager
    //
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    
    // Map item to a cell, this will also register the XIBTestCell.xib for the XIBTestItem identifier
    //
    self.manager[@"XIBTestItem"] = @"XIBTestCell";
    
    // Add a section
    //
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    for (NSInteger i = 1; i < 100; i++) {
        NSString *title = [NSString stringWithFormat:@"Item %li", (long) i];
        XIBTestItem *item = [XIBTestItem itemWithTitle:title
                                         accessoryType:UITableViewCellAccessoryNone
                                      selectionHandler:^(RETableViewItem *item) {
            [item deselectRowAnimated:YES];
        }];
        [section addItem:item];
    }
    
    // Cell is being assigned an automatic identifier
    //
    // You can manually set it if you want to:
    // item.cellIdentifier = @"CustomIdentifier";
    //
    // You'll need to register a cell class for it as well:
    // [self.tableView registerNib:[UINib nibWithNibName:@"XIBTestCell" bundle:nil] forCellReuseIdentifier:@"CustomIdentifier"];
}

@end
