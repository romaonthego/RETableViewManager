//
//  EditingViewController.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/13/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RETableViewManager.h"

@interface EditingViewController : UITableViewController <UIAlertViewDelegate>

@property (strong, readonly, nonatomic) RETableViewManager *manager;

// Deletable items with confirmation

@property (strong, readwrite, nonatomic) RETableViewItem *itemToDelete;
@property (copy, readwrite, nonatomic) void (^deleteConfirmationHandler)(void);

@end
