//
//  ControlsViewController.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 2/28/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ControlsViewController.h"
#import "MultilineTextItem.h"

@interface ControlsViewController ()

@property (strong, readwrite, nonatomic) RETableViewManager *manager;
@property (strong, readwrite, nonatomic) RETableViewSection *basicControlsSection;
@property (strong, readwrite, nonatomic) RETableViewSection *creditCardSection;
@property (strong, readwrite, nonatomic) RETableViewSection *accessoriesSection;
@property (strong, readwrite, nonatomic) RETableViewSection *cutCopyPasteSection;
@property (strong, readwrite, nonatomic) RETableViewSection *buttonSection;

@property (strong, readwrite, nonatomic) RETextItem *fullLengthFieldItem;
@property (strong, readwrite, nonatomic) RETextItem *textItem;
@property (strong, readwrite, nonatomic) RENumberItem *numberItem;
@property (strong, readwrite, nonatomic) RETextItem *passwordItem;
@property (strong, readwrite, nonatomic) REBoolItem *boolItem;
@property (strong, readwrite, nonatomic) REFloatItem *floatItem;
@property (strong, readwrite, nonatomic) REDateTimeItem *dateTimeItem;
@property (strong, readwrite, nonatomic) RERadioItem *radioItem;
@property (strong, readwrite, nonatomic) REMultipleChoiceItem *multipleChoiceItem;
@property (strong, readwrite, nonatomic) RELongTextItem *longTextItem;
@property (strong, readwrite, nonatomic) RECreditCardItem *creditCardItem;
@property (strong, readwrite, nonatomic) RECreditCardItem *creditCardItemCVV;
@property (strong, readwrite, nonatomic) REPickerItem *pickerItem;
@property (strong, readwrite, nonatomic) RESegmentedItem *segmentItem;
@property (strong, readwrite, nonatomic) RESegmentedItem *segmentItem2;

@end

@implementation ControlsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Controls";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Values" style:UIBarButtonItemStyleBordered target:self action:@selector(valuesButtonPressed:)];
    
    // Create manager
    //
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];

    self.basicControlsSection = [self addBasicControls];
    self.creditCardSection = [self addCreditCard];
    self.accessoriesSection = [self addAccessories];
    self.cutCopyPasteSection = [self addCutCopyPaste];
    self.buttonSection = [self addButton];
}

- (void)valuesButtonPressed:(id)sender
{
    NSLog(@"fullLengthFieldItem.value = %@", self.fullLengthFieldItem.value);
    NSLog(@"textItem.value = %@", self.textItem.value);
    NSLog(@"numberItem.value = %@", self.numberItem.value);
    NSLog(@"passwordItem.value = %@", self.passwordItem.value);
    NSLog(@"boolItem.value = %@", self.boolItem.value ? @"YES" : @"NO");
    NSLog(@"floatItem.value = %f", self.floatItem.value);
    NSLog(@"dateTimeItem = %@", self.dateTimeItem.value);
    NSLog(@"radioItem.value = %@", self.radioItem.value);
    NSLog(@"multipleChoiceItem.value = %@", self.multipleChoiceItem.value);
    NSLog(@"longTextItem.value = %@", self.longTextItem.value);
    NSLog(@"creditCardItem.number = %@, creditCardItem.expirationDate = %@, creditCardItem.cvv = %@", self.creditCardItem.number, self.creditCardItem.expirationDate, self.creditCardItem.cvv);
}

#pragma mark -
#pragma mark Basic Controls Example

- (RETableViewSection *)addBasicControls
{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Basic controls"];
    [self.manager addSection:section];
    
    // Custom item / cell
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    // Add items to this section
    //
    [section addItem:@"Simple NSString"];
    
    self.fullLengthFieldItem = [RETextItem itemWithTitle:nil value:nil placeholder:@"Full length text field"];    
    self.textItem = [RETextItem itemWithTitle:@"Text item" value:nil placeholder:@"Text"];
    self.numberItem = [RENumberItem itemWithTitle:@"Phone" value:@"" placeholder:@"(123) 456-7890" format:@"(XXX) XXX-XXXX"];
    self.numberItem.onEndEditing = ^(RENumberItem *item){
        NSLog(@"Value: %@", item.value);
    };
    self.passwordItem = [RETextItem itemWithTitle:@"Password" value:nil placeholder:@"Password item"];
    self.passwordItem.secureTextEntry = YES;
    self.boolItem = [REBoolItem itemWithTitle:@"Bool item" value:YES switchValueChangeHandler:^(REBoolItem *item) {
        NSLog(@"Value: %@", item.value ? @"YES" : @"NO");
    }];
    self.segmentItem = [RESegmentedItem itemWithTitle:@"Segmented" segmentedControlTitles:@[@"One", @"Two"] value:1 switchValueChangeHandler:^(RESegmentedItem *item) {
        NSLog(@"Value: %li", (long)item.value);
    }];
    self.segmentItem2 = [RESegmentedItem itemWithTitle:nil segmentedControlImages:@[[UIImage imageNamed:@"Heart"], [UIImage imageNamed:@"Heart_Highlighted"]] value:0 switchValueChangeHandler:^(RESegmentedItem *item) {
        NSLog(@"Value: %li", (long)item.value);
    }];
    self.segmentItem2.tintColor = [UIColor orangeColor];
    self.floatItem = [REFloatItem itemWithTitle:@"Float item" value:0.3 sliderValueChangeHandler:^(REFloatItem *item) {
        NSLog(@"Value: %f", item.value);
    }];
    self.dateTimeItem = [REDateTimeItem itemWithTitle:@"Date / Time" value:[NSDate date] placeholder:nil format:@"MM/dd/yyyy hh:mm a" datePickerMode:UIDatePickerModeDateAndTime];
    self.dateTimeItem.onChange = ^(REDateTimeItem *item){
        NSLog(@"Value: %@", item.value.description);
    };
    
    // Use inline date picker in iOS 7
    //
    if (REUIKitIsFlatMode()) {
        self.dateTimeItem.inlineDatePicker = YES;
    }
    
    self.pickerItem = [REPickerItem itemWithTitle:@"Picker" value:@[@"Item 12", @"Item 23"] placeholder:nil options:@[@[@"Item 11", @"Item 12", @"Item 13"], @[@"Item 21", @"Item 22", @"Item 23", @"Item 24"]]];
    self.pickerItem.onChange = ^(REPickerItem *item){
        NSLog(@"Value: %@", item.value);
    };
    
    // Use inline picker in iOS 7
    //
    if (REUIKitIsFlatMode()) {
        self.pickerItem.inlinePicker = YES;
    }
    
    self.radioItem = [RERadioItem itemWithTitle:@"Radio" value:@"Option 4" selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES]; // same as [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        
        // Generate sample options
        //
        NSMutableArray *options = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i < 40; i++)
            [options addObject:[NSString stringWithFormat:@"Option %li", (long) i]];
        
        // Present options controller
        //
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options multipleChoice:NO completionHandler:^(RETableViewItem *selectedItem){
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationNone]; // same as [weakSelf.tableView reloadRowsAtIndexPaths:@[item.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
        // Adjust styles
        //
        optionsController.delegate = weakSelf;
        optionsController.style = section.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        
        // Push the options controller
        //
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    self.multipleChoiceItem = [REMultipleChoiceItem itemWithTitle:@"Multiple" value:@[@"Option 2", @"Option 4"] selectionHandler:^(REMultipleChoiceItem *item) {
        [item deselectRowAnimated:YES];
        
        // Generate sample options
        //
        NSMutableArray *options = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i < 40; i++)
            [options addObject:[NSString stringWithFormat:@"Option %li", (long) i]];
        
        // Present options controller
        //
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options multipleChoice:YES completionHandler:^(RETableViewItem *selectedItem){
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
            NSLog(@"parent: %@, child: %@", item.value, selectedItem.title);
        }];
        
        // Adjust styles
        //
        optionsController.delegate = weakSelf;
        optionsController.style = section.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        
        // Push the options controller
        //
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    self.longTextItem = [RELongTextItem itemWithValue:nil placeholder:@"Multiline text field"];
    self.longTextItem.cellHeight = 88;

    
    [section addItem:self.fullLengthFieldItem];
    [section addItem:self.textItem];
    [section addItem:self.numberItem];
    [section addItem:self.passwordItem];
    [section addItem:self.boolItem];
    [section addItem:self.floatItem];
    [section addItem:self.dateTimeItem];
    [section addItem:self.pickerItem];
    [section addItem:self.radioItem];
    [section addItem:self.multipleChoiceItem];
    [section addItem:self.segmentItem];
    [section addItem:self.segmentItem2];
    [section addItem:self.longTextItem];
    
    [section addItem:[MultilineTextItem itemWithTitle:@"Custom item / cell example. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sem leo, malesuada tempor metus et, elementum pulvinar nibh."]];
    
    RETableViewItem *titleAndImageItem = [RETableViewItem itemWithTitle:@"Text and image item" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
    }];
    titleAndImageItem.image = [UIImage imageNamed:@"Heart"];
    titleAndImageItem.highlightedImage = [UIImage imageNamed:@"Heart_Highlighted"];
    [section addItem:titleAndImageItem];
    
    return section;
}

#pragma mark -
#pragma mark Credit Card Example

- (RETableViewSection *)addCreditCard
{
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Credit card"];
    [self.manager addSection:section];
    self.creditCardItem = [RECreditCardItem item];
    [section addItem:self.creditCardItem];
    
    return section;
}

#pragma mark -
#pragma mark Accessories Example

- (RETableViewSection *)addAccessories
{
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Accessories" footerTitle:@"This section holds items with accessories."];

    [self.manager addSection:section];

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
    
    return section;
}

#pragma mark -
#pragma mark Cut, Copy and Paste Example

- (RETableViewSection *)addCutCopyPaste
{
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Copy / pasting"];

    section.footerTitle = @"This section holds items that support copy and pasting. You can tap on an item to copy it, while you can tap on another one to paste it.";

    [self.manager addSection:section];
    
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
    
    return section;
}

#pragma mark -
#pragma mark Button Example

- (RETableViewSection *)addButton
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"Test button" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        item.title = @"Pressed!";
        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
    return section;
}

@end
