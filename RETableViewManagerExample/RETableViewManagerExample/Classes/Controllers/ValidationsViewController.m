//
//  ValidationsViewController.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 8/22/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ValidationsViewController.h"

@interface ValidationsViewController ()

@property (strong, readwrite, nonatomic) RETextItem *textItem;
@property (strong, readwrite, nonatomic) RETextItem *emailItem;

@end

@implementation ValidationsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Controls";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Validate" style:UIBarButtonItemStyleBordered target:self action:@selector(validateButtonPressed:)];
    
    // Create manager
    //
    _manager = [[RETableViewManager alloc] initWithTableView:self.tableView];
    
    // Add a section
    //
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Basic controls"];
    [_manager addSection:section];
    
    // Add items
    //
    self.textItem = [RETextItem itemWithTitle:@"Text" value:@"" placeholder:@"Text item"];
    self.textItem.validators = @[@"presence", @"length(3, 10)"];
    
    self.emailItem = [RETextItem itemWithTitle:@"Email" value:@"" placeholder:@"Email item"];
    self.emailItem.name = @"Your email";
    self.emailItem.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailItem.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.emailItem.validators = @[@"presence", @"email"];
    
    [section addItem:self.textItem];
    [section addItem:self.emailItem];
}

#pragma mark -
#pragma mark Button actions

- (void)validateButtonPressed:(UIButton *)sender
{
    if (self.manager.errors) {
        NSMutableArray *errors = [NSMutableArray array];
        for (NSError *error in self.manager.errors) {
            [errors addObject:error.localizedDescription];
        }
        NSString *errorString = [errors componentsJoinedByString:@"\n"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Errors" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        NSLog(@"All good, no errors!");
    }
}

@end
