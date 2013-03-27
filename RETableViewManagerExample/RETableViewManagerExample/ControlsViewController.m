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
    
    // Set delegate and datasource
    //
    self.tableView.dataSource = _manager;
    self.tableView.delegate = _manager;
    
    // Create section
    //
    RETableViewSection *section = [[RETableViewSection alloc] initWithHeaderTitle:@"Basic controls"];
    [_manager addSection:section];
    
    // Add items
    //
    [section addItem:@"Simple NSString"];
    RETextItem *fullLengthField = [RETextItem itemWithTitle:nil value:nil placeholder:@"Full length text field"];
    [section addItem:fullLengthField];
    
    RETextItem *passwordItem = [RETextItem itemWithTitle:@"Password" value:nil placeholder:@"Password field"];
    passwordItem.secureTextEntry = YES;
    [section addItem:passwordItem];
    [section addItem:[RETextItem itemWithTitle:@"Text item 1" value:nil placeholder:@"Text"]];
    [section addItem:[RETextItem itemWithTitle:@"Text item 2" value:nil placeholder:@"Text"]];
    [section addItem:[RETextItem itemWithTitle:@"Text item 3" value:nil placeholder:@"Text"]];
    [section addItem:[RETextItem itemWithTitle:@"Text item 4" value:nil placeholder:@"Text"]];
    [section addItem:[REBoolItem itemWithTitle:@"Bool item" value:YES]];
    
    section = [[RETableViewSection alloc] initWithHeaderTitle:@"Basic controls"];
    [_manager addSection:section];
    [section addItem:[RETextItem itemWithTitle:@"Text item 1" value:nil placeholder:@"Text"]];
    
    section = [[RETableViewSection alloc] initWithHeaderTitle:@"Credit card"];
    [_manager addSection:section];
    [section addItem:[RECreditCardItem item]];
    
    // ------
    
    __typeof (&*self) __weak weakSelf = self;
    
    // Create another section
    //
    RETableViewSection *section2 = [[RETableViewSection alloc] initWithHeaderTitle:@"Accessories"];
    [_manager addSection:section2];
    
    // Add items to this section
    //
    [section2 addItem:[REStringItem itemWithTitle:@"Accessory 1" accessoryType:UITableViewCellAccessoryDisclosureIndicator actionBlock:^(RETableViewItem *item) {
        [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
    }]];
    
    [section2 addItem:[REStringItem itemWithTitle:@"Accessory 2" accessoryType:UITableViewCellAccessoryDetailDisclosureButton actionBlock:^(RETableViewItem *item) {
        [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
    } accessoryButtonActionBlock:^(RETableViewItem *item) {
        NSLog(@"Accessory button in accessoryItem2 was tapped");
    }]];
    
    [section2 addItem:[REStringItem itemWithTitle:@"Accessory 2" accessoryType:UITableViewCellAccessoryCheckmark actionBlock:^(RETableViewItem *item) {
        [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
    }]];
}

@end
