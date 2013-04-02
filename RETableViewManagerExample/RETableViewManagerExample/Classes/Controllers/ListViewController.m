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

@end

@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"List";
    
    // Create manager
    //
    _manager = [[RETableViewManager alloc] init];
    
    // Map item to a cell
    //
    [_manager mapObjectClass:@"ListImageItem" toTableViewCellClass:@"ListImageCell"];
    
    // Set delegate and datasource
    //
    self.tableView.dataSource = _manager;
    self.tableView.delegate = _manager;
    
    // Set some UITableView properties
    //
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 7)];
    
    NSArray *items = @[@{@"username": @"john",
                         @"userpic_url": @"http://uifaces.com/faces/_twitter/utroda_120.jpg",
                         @"image_url": @"http://distilleryimage10.instagram.com/09b742a2962611e2a84922000a1f8c0f_7.jpg"},
                       
                       @{@"username": @"mark",
                         @"userpic_url": @"http://uifaces.com/faces/_twitter/eldelentes_120.jpg",
                         @"image_url": @"http://distilleryimage2.s3.amazonaws.com/34e4fb8e91a011e2a47b22000a1f99e6_7.jpg"},
                       
                       @{@"username": @"william",
                         @"userpic_url": @"http://uifaces.com/faces/_twitter/daniel_love_120.jpg",
                         @"image_url": @"http://distilleryimage2.ak.instagram.com/9ab3ff16b59911e1b00112313800c5e4_7.jpg"},
                       
                       @{@"username": @"gretchen",
                         @"userpic_url": @"http://uifaces.com/faces/_twitter/JuliaYunLiu_120.jpg",
                         @"image_url": @"http://distilleryimage10.s3.amazonaws.com/b9e61198b69411e180d51231380fcd7e_7.jpg"}
                       ];
    
    RETableViewSection *section;
    
    for (NSDictionary *dictionary in items) {
        NSString *username = [dictionary objectForKey:@"username"];
        NSURL *userpicURL = [NSURL URLWithString:[dictionary objectForKey:@"userpic_url"]];
        NSURL *imageURL = [NSURL URLWithString:[dictionary objectForKey:@"image_url"]];
        
        // Create section with header view
        //
        section = [[RETableViewSection alloc] initWithHeaderView:[ListHeaderView headerViewWithImageURL:userpicURL username:username]];
        [_manager addSection:section];
        
        // Add item (image)
        //
        [section addItem:[ListImageItem itemWithImageURL:imageURL]];
    }
}

@end
