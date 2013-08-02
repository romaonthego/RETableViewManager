//
//  ControlsViewController.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 2/28/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ControlsViewController.h"

@interface ControlsViewController ()

@end

@implementation ControlsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Controls";
    
    // Create manager
    //
    _manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];

    [self addBasicControls];
    [self addCreditCard];
    [self addAccessories];
    [self addCutCopyPaste];
    [self addButton];
}

#pragma mark -
#pragma mark Basic Controls Example

- (void)addBasicControls
{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Basic controls"];
    [_manager addSection:section];
    
    // Add items to this section
    //
    [section addItem:@"Simple NSString"];
    
    RETextItem *fullLengthField = [RETextItem itemWithTitle:nil value:nil placeholder:@"Full length text field"];
    [section addItem:fullLengthField];
    
    [section addItem:[RETextItem itemWithTitle:@"Text item" value:nil placeholder:@"Text"]];
    [section addItem:[RENumberItem itemWithTitle:@"Phone" value:@"" placeholder:@"(123) 456-7890" format:@"(XXX) XXX-XXXX"]];
    
    RETextItem *passwordItem = [RETextItem itemWithTitle:@"Password" value:nil placeholder:@"Password item"];
    passwordItem.secureTextEntry = YES;
    [section addItem:passwordItem];
    
    [section addItem:[REBoolItem itemWithTitle:@"Bool item" value:YES switchValueChangeHandler:^(REBoolItem *item) {
        NSLog(@"Value: %@", item.value ? @"YES" : @"NO");
    }]];
    
    [section addItem:[REFloatItem itemWithTitle:@"Float item" value:0.3 sliderValueChangeHandler:^(REFloatItem *item) {
        NSLog(@"Value: %f", item.value);
    }]];
    
    [section addItem:[REDateTimeItem itemWithTitle:@"Date / Time" value:[NSDate date] placeholder:nil format:@"MM/dd/yyyy hh:mm a" datePickerMode:UIDatePickerModeDateAndTime]];
    
    RERadioItem *optionItem = [RERadioItem itemWithTitle:@"Radio" value:@"Option 4" selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES]; // same as [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        
        // Generate sample options
        //
        NSMutableArray *options = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i < 40; i++)
            [options addObject:[NSString stringWithFormat:@"Option %i", i]];
        
        // Present options controller
        //
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationNone]; // same as [weakSelf.tableView reloadRowsAtIndexPaths:@[item.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
        // Adjust styles
        //
        optionsController.style = weakSelf.manager.style;
        optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
        optionsController.tableView.backgroundView = weakSelf.tableView.backgroundView;
        
        // Push the options controller
        //
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    [section addItem:optionItem];
    
    REMultipleChoiceItem *multipleItem = [REMultipleChoiceItem itemWithTitle:@"Multiple" value:@[@"Option 2", @"Option 4"] selectionHandler:^(REMultipleChoiceItem *item) {
        [item deselectRowAnimated:YES];
        
        // Generate sample options
        //
        NSMutableArray *options = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i < 40; i++)
            [options addObject:[NSString stringWithFormat:@"Option %i", i]];
        
        // Present options controller
        //
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options multipleChoice:YES completionHandler:^{
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
            NSLog(@"%@", item.value);
        }];
        
        // Adjust styles
        //
        optionsController.style = weakSelf.manager.style;
        optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
        optionsController.tableView.backgroundView = weakSelf.tableView.backgroundView;
        
        // Push the options controller
        //
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    [section addItem:multipleItem];
    
    RELongTextItem *longTextItem = [RELongTextItem itemWithValue:nil placeholder:@"Multiline text field"];
    longTextItem.cellHeight = 88;
    [section addItem:longTextItem];
}

#pragma mark -
#pragma mark Credit Card Example

- (void)addCreditCard
{
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Credit card"];
    [_manager addSection:section];
    [section addItem:[RECreditCardItem item]];
}

#pragma mark -
#pragma mark Accessories Example

- (void)addAccessories
{
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Accessories"];
    [_manager addSection:section];
    
    // Add items to this section
    //
    [section addItem:[RETableViewItem itemWithTitle:@"Accessory 1" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
    }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"Accessory 2" accessoryType:UITableViewCellAccessoryDetailDisclosureButton selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
    } accessoryButtonTapHandler:^(RETableViewItem *item) {
        NSLog(@"Accessory button in accessoryItem2 was tapped");
    }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"Accessory 2" accessoryType:UITableViewCellAccessoryCheckmark selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
    }]];
}

#pragma mark -
#pragma mark Cut, Copy and Paste Example

- (void)addCutCopyPaste
{
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Copy / pasting"];
    [_manager addSection:section];
    
    RETableViewItem *copyItem = [RETableViewItem itemWithTitle:@"Long tap to copy this item" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
    }];
    copyItem.copyHandler = ^(RETableViewItem *item) {
        [UIPasteboard generalPasteboard].string = @"Copied item #1";
    };
    [section addItem:copyItem];
    
    RETableViewItem *pasteItem = [RETableViewItem itemWithTitle:@"Long tap to paste into this item" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
    }];
    pasteItem.pasteHandler = ^(RETableViewItem *item) {
        item.title = [UIPasteboard generalPasteboard].string;
        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
    };
    [section addItem:pasteItem];
    
    RETableViewItem *cutCopyPasteItem = [RETableViewItem itemWithTitle:@"Long tap to cut / copy / paste" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
    }];
    cutCopyPasteItem.copyHandler = ^(RETableViewItem *item) {
        [UIPasteboard generalPasteboard].string = @"Copied item #3";
    };
    cutCopyPasteItem.pasteHandler = ^(RETableViewItem *item) {
        item.title = [UIPasteboard generalPasteboard].string;
        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
    };
    cutCopyPasteItem.cutHandler = ^(RETableViewItem *item) {
        item.title = @"(Empty)";
        [UIPasteboard generalPasteboard].string = @"Copied item #3";
        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
    };
    [section addItem:cutCopyPasteItem];
}

#pragma mark -
#pragma mark Button Example

- (void)addButton
{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection section];
    [_manager addSection:section];
    
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"Test button" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        NSLog(@"Button pressed");
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
}

@end
