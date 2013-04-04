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

@end

@implementation RETableViewOptionsController

- (id)initWithItem:(RETableViewItem *)item options:(NSArray *)options completionHandler:(void(^)(RETableViewItem *selectedItem))completionHandler
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self)
        return nil;
    
    self.item = item;
    self.options = options;
    self.title = item.title;
    self.completionHandler = completionHandler;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableViewManager = [[RETableViewManager alloc] init];
    _mainSection = [[RETableViewSection alloc] init];
    [_tableViewManager addSection:_mainSection];
    
    __typeof (&*self) __weak weakSelf = self;
    void (^addItem)(NSString *title) = ^(NSString *title) {
        UITableViewCellAccessoryType accessoryType = UITableViewCellAccessoryNone;
        if ([title isEqualToString:self.item.detailLabelText])
            accessoryType = UITableViewCellAccessoryCheckmark;
        [_mainSection addItem:[RETableViewItem itemWithTitle:title accessoryType:accessoryType actionBlock:^(RETableViewItem *item) {
            UITableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:item.indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [weakSelf.navigationController popViewControllerAnimated:YES];
            if (weakSelf.completionHandler)
                weakSelf.completionHandler(item);
        }]];
    };
    
    for (RETableViewItem *item in self.options)
        addItem([item isKindOfClass:[RETableViewItem item]] ? item.title : (NSString *)item);
    
    // Set datasource and delegate
    //
    self.tableView.delegate = _tableViewManager;
    self.tableView.dataSource = _tableViewManager;
}

@end
