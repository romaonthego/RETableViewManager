//
//  EditingViewController.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/13/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "EditingViewController.h"

@interface EditingViewController ()

@end

@implementation EditingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"Editing";
    
    //__typeof (&*self) __weak weakSelf = self;
    
    // Create manager
    //
    _manager = [[RETableViewManager alloc] init];
    _manager.style.textFieldPositionOffset = CGSizeMake(0, 0);
    
    // Set delegate and datasource
    //
    self.tableView.dataSource = _manager;
    self.tableView.delegate = _manager;
    
    // Add sections and items
    //
    RETableViewSection *section = [[RETableViewSection alloc] initWithHeaderTitle:@"Section 1"];
    [_manager addSection:section];
    
    for (NSInteger i = 1; i <= 10; i++) {
        RETableViewItem *item = [RETableViewItem itemWithTitle:[NSString stringWithFormat:@"Item %i", i] accessoryType:UITableViewCellAccessoryNone selectionHandler:nil];
        item.deletable = YES;
        item.deletionHandler = ^(RETableViewItem *item) {
            NSLog(@"Item removed: %@", item.title);
        };
        [section addItem:item];
    }
    
    section = [[RETableViewSection alloc] initWithHeaderTitle:@"Section 2"];
    [_manager addSection:section];
    
    for (NSInteger i = 1; i <= 10; i++) {
        RETableViewItem *item = [RETableViewItem itemWithTitle:[NSString stringWithFormat:@"Item %i", i] accessoryType:UITableViewCellAccessoryNone selectionHandler:nil];
        [section addItem:item];
    }
}

@end
