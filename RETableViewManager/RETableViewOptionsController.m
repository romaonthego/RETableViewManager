//
// RETableViewOptionsController.m
// RETableViewManager
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
#import "RETableViewOptionsController.h"
#import "RETableViewItem.h"
#import "RETableViewManager.h"

@interface RETableViewOptionsController ()

@property (strong, readwrite, nonatomic) RETableViewManager *tableViewManager;
@property (strong, readwrite, nonatomic) RETableViewSection *mainSection;

@end

@implementation RETableViewOptionsController

- (id)initWithItem:(RETableViewItem *)item options:(NSArray *)options multipleChoice:(BOOL)multipleChoice completionHandler:(void(^)(RETableViewItem *item))completionHandler
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self)
        return nil;
    
    self.item = item;
    self.options = options;
    self.title = item.title;
    self.multipleChoice = multipleChoice;
    self.completionHandler = completionHandler;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableViewManager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self.delegate];
    self.mainSection = [[RETableViewSection alloc] init];
    [self.tableViewManager addSection:self.mainSection];
    
    if (self.style)
        self.tableViewManager.style = self.style;
    
    __typeof (&*self) __weak weakSelf = self;
    void (^refreshItems)(void) = ^{
        REMultipleChoiceItem * __weak item = (REMultipleChoiceItem *)weakSelf.item;
        NSMutableArray *results = [[NSMutableArray alloc] init];
        for (RETableViewItem *sectionItem in weakSelf.mainSection.items) {
            for (NSString *strValue in item.value) {
                if ([strValue isEqualToString:sectionItem.title])
                    [results addObject:sectionItem.title];
            }
        }
        item.value = results;
    };
    
    void (^addItem)(NSString *title) = ^(NSString *title) {
        UITableViewCellAccessoryType accessoryType = UITableViewCellAccessoryNone;
        if (!weakSelf.multipleChoice) {
            if ([title isEqualToString:self.item.detailLabelText])
                accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            REMultipleChoiceItem * __weak item = (REMultipleChoiceItem *)weakSelf.item;
            for (NSString *strValue in item.value) {
                if ([strValue isEqualToString:title]) {
                    accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }
        }
        [self.mainSection addItem:[RETableViewItem itemWithTitle:title accessoryType:accessoryType selectionHandler:^(RETableViewItem *selectedItem) {
            UITableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:selectedItem.indexPath];
            if (!weakSelf.multipleChoice) {
                for (NSIndexPath *indexPath in [weakSelf.tableView indexPathsForVisibleRows]) {
                    UITableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:indexPath];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                for (RETableViewItem *item in weakSelf.mainSection.items) {
                    item.accessoryType = UITableViewCellAccessoryNone;
                }
                selectedItem.accessoryType = UITableViewCellAccessoryCheckmark;
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                RERadioItem * __weak item = (RERadioItem *)weakSelf.item;
                item.value = selectedItem.title;
                if (weakSelf.completionHandler)
                    weakSelf.completionHandler(selectedItem);
            } else { // Multiple choice item
                REMultipleChoiceItem * __weak item = (REMultipleChoiceItem *)weakSelf.item;
                [weakSelf.tableView deselectRowAtIndexPath:selectedItem.indexPath animated:YES];
                if (selectedItem.accessoryType == UITableViewCellAccessoryCheckmark) {
                    selectedItem.accessoryType = UITableViewCellAccessoryNone;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    NSMutableArray *items = [[NSMutableArray alloc] init];
                    for (NSString *val in item.value) {
                        if (![val isEqualToString:selectedItem.title])
                            [items addObject:val];
                    }
                    
                    item.value = items;
                } else {
                    selectedItem.accessoryType = UITableViewCellAccessoryCheckmark;
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:item.value];
                    [items addObject:selectedItem.title];
                    item.value = items;
                    refreshItems();
                }
                if (weakSelf.completionHandler)
                    weakSelf.completionHandler(selectedItem);
            }
        }]];
    };
    
    for (RETableViewItem *item in self.options) {
        addItem([item isKindOfClass:[[RERadioItem item] class]] ? item.title : (NSString *)item);
    }
}

@end
