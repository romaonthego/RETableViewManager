//
//  IndexedListViewController.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 8/14/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "IndexedListViewController.h"

@interface IndexedListViewController ()

@end

@implementation IndexedListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Indexed List";
    
    // Create manager
    //
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView];
    
    NSArray *sectionTitles = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M",
                               @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];

    // Add sections and items
    //
    for (NSString *sectionTitle in sectionTitles) {
        RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:sectionTitle];
        section.indexTitle = sectionTitle; // assign index title
        
        // Add 5 items with name `section title + item index`
        //
        for (NSInteger i = 1; i <= 5; i++)
            [section addItem:[NSString stringWithFormat:@"%@%i", sectionTitle, i]];
        
        [self.manager addSection:section];
    }
}

@end
