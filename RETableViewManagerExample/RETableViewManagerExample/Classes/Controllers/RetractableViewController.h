//
//  RetractableViewController.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 6/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RETableViewManager.h"

@interface RetractableViewController : UITableViewController

@property (strong, readonly, nonatomic) RETableViewManager *manager;
@property (strong, readonly, nonatomic) RETableViewSection *section;

@end
