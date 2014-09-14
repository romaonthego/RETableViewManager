//
//  StylingViewController.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 6/13/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "StylingViewController.h"

@interface StylingViewController ()

@end

@implementation StylingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Styling";
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.967 green:1.000 blue:0.974 alpha:1.000];
    
    // Style action bar
    //
    [[REActionBar appearance] setTintColor:[UIColor colorWithRed:61/255.0 green:119/255.0 blue:58/255.0 alpha:1.000]];
    
    // Set default cell height
    //
    self.manager.style.cellHeight = 42.0;
    
    // Set cell background image
    //
	[self.manager.style setBackgroundImage:[[UIImage imageNamed:@"First"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                               forCellType:RETableViewCellTypeFirst];
    [self.manager.style setBackgroundImage:[[UIImage imageNamed:@"Middle"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                               forCellType:RETableViewCellTypeMiddle];
    [self.manager.style setBackgroundImage:[[UIImage imageNamed:@"Last"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                               forCellType:RETableViewCellTypeLast];
    [self.manager.style setBackgroundImage:[[UIImage imageNamed:@"Single"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                               forCellType:RETableViewCellTypeSingle];
    
    // Set selected cell background image
    //
    [self.manager.style setSelectedBackgroundImage:[[UIImage imageNamed:@"First_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                                       forCellType:RETableViewCellTypeFirst];
    [self.manager.style setSelectedBackgroundImage:[[UIImage imageNamed:@"Middle_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                                       forCellType:RETableViewCellTypeMiddle];
    [self.manager.style setSelectedBackgroundImage:[[UIImage imageNamed:@"Last_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                                       forCellType:RETableViewCellTypeLast];
    [self.manager.style setSelectedBackgroundImage:[[UIImage imageNamed:@"Single_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                                       forCellType:RETableViewCellTypeSingle];
   
    // Retain legacy grouped cell style in iOS 7
    //
    if (REUIKitIsFlatMode()) {
        self.manager.style.backgroundImageMargin = 10.0;
    }
    
    // Set a custom style for a particular section
    //
    self.accessoriesSection.style = [self.manager.style copy];
    [self.accessoriesSection.style setBackgroundImage:[[UIImage imageNamed:@"First_Alt"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                               forCellType:RETableViewCellTypeFirst];
    [self.accessoriesSection.style setBackgroundImage:[[UIImage imageNamed:@"Middle_Alt"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                               forCellType:RETableViewCellTypeMiddle];
    [self.accessoriesSection.style setBackgroundImage:[[UIImage imageNamed:@"Last_Alt"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                               forCellType:RETableViewCellTypeLast];
    [self.accessoriesSection.style setBackgroundImage:[[UIImage imageNamed:@"Single_Alt"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
                               forCellType:RETableViewCellTypeSingle];
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]] || [view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]])
            ((UILabel *)view).font = [UIFont fontWithName:@"Avenir-Medium" size:16];
    }
    
    if ([cell isKindOfClass:[RETableViewCreditCardCell class]]) {
        RETableViewCreditCardCell *ccCell = (RETableViewCreditCardCell *)cell;
        ccCell.creditCardField.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
        ccCell.expirationDateField.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
        ccCell.cvvField.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
    }
}

@end
