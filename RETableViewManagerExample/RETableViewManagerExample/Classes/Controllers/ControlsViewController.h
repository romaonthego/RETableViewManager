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
@property (strong, readwrite, nonatomic) RETableViewSection *basicControlsSection;
@property (strong, readwrite, nonatomic) RETableViewSection *creditCardSection;
@property (strong, readwrite, nonatomic) RETableViewSection *accessoriesSection;
@property (strong, readwrite, nonatomic) RETableViewSection *cutCopyPasteSection;
@property (strong, readwrite, nonatomic) RETableViewSection *buttonSection;

@end
