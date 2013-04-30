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
    
    __typeof (&*self) __weak weakSelf = self;
    
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
    RETableViewSection *section = [[RETableViewSection alloc] initWithHeaderTitle:@"Deletable"];
    [_manager addSection:section];
    
    for (NSInteger i = 1; i <= 5; i++) {
        RETableViewItem *item = [RETableViewItem itemWithTitle:[NSString stringWithFormat:@"Section 1, Item %i", i] accessoryType:UITableViewCellAccessoryNone selectionHandler:nil];
        item.editingStyle = UITableViewCellEditingStyleDelete;
        item.deletionHandler = ^(RETableViewItem *item) {
            NSLog(@"Item removed: %@", item.title);
        };
        [section addItem:item];
    }
    
    section = [[RETableViewSection alloc] initWithHeaderTitle:@"Deletable with confirmation"];
    [_manager addSection:section];
    
    for (NSInteger i = 1; i <= 5; i++) {
        RETableViewItem *item = [RETableViewItem itemWithTitle:[NSString stringWithFormat:@"Section 2, Item %i", i] accessoryType:UITableViewCellAccessoryNone selectionHandler:nil];
        item.editingStyle = UITableViewCellEditingStyleDelete;
        item.deletionHandlerWithCompletion = ^(RETableViewItem *item, void (^completion)(void)) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:[NSString stringWithFormat:@"Are you sure you want to delete %@", item.title] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
            [alert show];
            weakSelf.currentItem = item;
            weakSelf.deleteConfirmationHandler = completion;
        };
        [section addItem:item];
    }
    
    section = [[RETableViewSection alloc] initWithHeaderTitle:@"Movable"];
    [_manager addSection:section];
    
    for (NSInteger i = 1; i <= 5; i++) {
        RETableViewItem *item = [RETableViewItem itemWithTitle:[NSString stringWithFormat:@"Section 3, Item %i", i] accessoryType:UITableViewCellAccessoryNone selectionHandler:nil];
        item.movable = YES;
        item.moveCompletionHandler = ^(RETableViewItem *item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath) {
            NSLog(@"Moved item: %@ from [%i,%i] to [%i,%i]", item.title, sourceIndexPath.section, sourceIndexPath.row, destinationIndexPath.section, destinationIndexPath.row);
        };
        [section addItem:item];
    }
    
    section = [[RETableViewSection alloc] initWithHeaderTitle:@"Deletable & Movable"];
    [_manager addSection:section];
    
    for (NSInteger i = 1; i <= 5; i++) {
        RETableViewItem *item = [RETableViewItem itemWithTitle:[NSString stringWithFormat:@"Section 4, Item %i", i] accessoryType:UITableViewCellAccessoryNone selectionHandler:nil];
        item.editingStyle = UITableViewCellEditingStyleDelete;
        item.movable = YES;
        item.moveCompletionHandler = ^(RETableViewItem *item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath) {
            NSLog(@"Moved item: %@ from [%i,%i] to [%i,%i]", item.title, sourceIndexPath.section, sourceIndexPath.row, destinationIndexPath.section, destinationIndexPath.row);
        };
        [section addItem:item];
    }
    
    section = [[RETableViewSection alloc] initWithHeaderTitle:@"Can move only within this section"];
    [_manager addSection:section];
    
    for (NSInteger i = 1; i <= 5; i++) {
        RETableViewItem *item = [RETableViewItem itemWithTitle:[NSString stringWithFormat:@"Section 5, Item %i", i] accessoryType:UITableViewCellAccessoryNone selectionHandler:nil];
        item.movable = YES;
        item.allowNewIndexPath = ^BOOL(id item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath) {
            return (destinationIndexPath.section == section.index);
        };
        [section addItem:item];
    }
    
    section = [[RETableViewSection alloc] initWithHeaderTitle:@"Insert style"];
    [_manager addSection:section];
    RETableViewItem *item = [RETableViewItem itemWithTitle:[NSString stringWithFormat:@"Section 6, Item %i", 1] accessoryType:UITableViewCellAccessoryNone selectionHandler:nil];
    item.insertionHandler = ^(RETableViewItem *item) {
        NSLog(@"Insertion handler callback");
    };
    item.editingStyle = UITableViewCellEditingStyleInsert;
    [section addItem:item];
}

#pragma mark -
#pragma mark UIAlertViewDeletate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        self.deleteConfirmationHandler();
        NSLog(@"Item removed: %@", self.currentItem.title);
    }
}

@end
