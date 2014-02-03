//
//  ListViewController.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 3/17/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ListViewController.h"
#import "ListHeaderView.h"
#import "ListImageItem.h"

@interface ListViewController ()

@property (strong, readwrite, nonatomic) RETableViewManager *manager;

@end

@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"List";
    
    // Create manager
    //
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView];
    
    // Map item to a cell
    //
    self.manager[@"ListImageItem"] = @"ListImageCell"; // which is the same as [self.manager registerClass:@"ListImageItem" forCellWithReuseIdentifier:@"ListImageCell"];
    
    // Set some UITableView properties
    //
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Add table footer view
    //
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 58)];
    [self.tableView.tableFooterView addSubview:({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(40, 7, 240, 44);
        button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [button setTitle:@"Load more" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(loadMoreButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button;
    })];
    
    // Add items
    //
    [self addItems];
}

- (void)addItems
{
    NSArray *items = @[@{@"username": @"john",
                         @"userpic": @"userpic1.jpg",
                         @"image": @"photo1.jpg"},
                       
                       @{@"username": @"mark",
                         @"userpic": @"userpic2.jpg",
                         @"image": @"photo2.jpg"},
                       
                       @{@"username": @"william",
                         @"userpic": @"userpic3.jpg",
                         @"image": @"photo3.jpg"},
                       
                       @{@"username": @"gretchen",
                         @"userpic": @"userpic4.jpg",
                         @"image": @"photo4.jpg"},
                       
                       @{@"username": @"roman",
                         @"userpic": @"userpic5.jpg",
                         @"image": @"photo5.jpg"},
                       
                       @{@"username": @"andrew",
                         @"userpic": @"userpic6.jpg",
                         @"image": @"photo6.jpg"}
                       ];
    
    for (NSDictionary *dictionary in items) {
        // Create section with a header view
        //
        ListHeaderView *headerView = [ListHeaderView headerViewWithImageNamed:dictionary[@"userpic"] username:dictionary[@"username"]];
        RETableViewSection *section = [RETableViewSection sectionWithHeaderView:headerView];
        [self.manager addSection:section];
        
        // Add item (image)
        //
        [section addItem:[ListImageItem itemWithImageNamed:dictionary[@"image"]]];
    }
}

#pragma mark -
#pragma mark Button actions

- (void)loadMoreButtonPressed:(id)sender
{
    [self addItems];
    [self.tableView reloadData];
}

@end
