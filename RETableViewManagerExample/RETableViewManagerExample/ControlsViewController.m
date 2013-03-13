//
//  ControlsViewController.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 2/28/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ControlsViewController.h"

@interface ControlsViewController ()

@end

@implementation ControlsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Controls";
    
    // Create manager
    //
    _manager = [[RETableViewManager alloc] init];
    _manager.style.textFieldPositionOffset = CGSizeMake(0, 0);
    
    RETableViewSection *section = [[RETableViewSection alloc] initWithHeaderTitle:@"Basic controls"];
    [_manager addSection:section];
    
    [section addItem:@"Simple NSString"];
    RETextItem *fullLengthField = [RETextItem itemWithTitle:nil value:nil placeholder:@"Full length text field"];
    [section addItem:fullLengthField];
    [section addItem:[RETextItem itemWithTitle:@"Text item 1" value:nil placeholder:@"Text"]];
    [section addItem:[RETextItem itemWithTitle:@"Text item 2" value:nil placeholder:@"Text"]];
    [section addItem:[RETextItem itemWithTitle:@"Text item 3 werw ererer" value:nil placeholder:@"Text"]];
    [section addItem:[RETextItem itemWithTitle:@"Text item 4" value:nil placeholder:@"Text"]];
    [section addItem:[REBoolItem itemWithTitle:@"Bool item" value:YES]];
    
    section = [[RETableViewSection alloc] initWithHeaderTitle:@"Basic controls"];
    [_manager addSection:section];
    [section addItem:[RETextItem itemWithTitle:@"Text item 1" value:nil placeholder:@"Text"]];
    
    section = [[RETableViewSection alloc] initWithHeaderTitle:@"Credit card"];
    [_manager addSection:section];
    [section addItem:[RECreditCardItem item]];
    
    // Set delegate and datasource
    //
    self.tableView.dataSource = _manager;
    self.tableView.delegate =  _manager;
}

@end
