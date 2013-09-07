//
//  ControlsViewController.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 2/28/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RETableViewManager.h"
#import "RETableViewOptionsController.h"

@interface ControlsViewController : UITableViewController <RETableViewManagerDelegate>

@property (strong, readonly, nonatomic) RETableViewManager *manager;
@property (strong, readonly, nonatomic) RETableViewSection *basicControlsSection;
@property (strong, readonly, nonatomic) RETableViewSection *creditCardSection;
@property (strong, readonly, nonatomic) RETableViewSection *accessoriesSection;
@property (strong, readonly, nonatomic) RETableViewSection *cutCopyPasteSection;
@property (strong, readonly, nonatomic) RETableViewSection *buttonSection;

@end
