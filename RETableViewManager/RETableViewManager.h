//
// RETableViewManager.h
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

#import <UIKit/UIKit.h>
#import "RETableViewSection.h"
#import "RETableViewCellStyle.h"
#import "RETableViewCell.h"
#import "RETableViewStringCell.h"
#import "RETableViewNumberCell.h"
#import "RETableViewCreditCardCell.h"

#import "REBoolItem.h"
#import "RETextItem.h"
#import "RENumberItem.h"
#import "RECreditCardItem.h"

@protocol RETableViewManagerDelegate;

@interface RETableViewManager : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *sections;
@property (strong, nonatomic) NSMutableDictionary *mapping;
@property (strong, nonatomic) RETableViewCellStyle *style;
@property (assign, nonatomic) id<RETableViewManagerDelegate>delegate;

- (id)initWithDelegate:(id)delegate;
- (RETableViewSection *)addSection:(RETableViewSection *)section;
- (void)mapObjectClass:(NSString *)objectClass toTableViewCellClass:(NSString *)cellViewClass;

@end

@protocol RETableViewManagerDelegate <NSObject>

@optional

- (void)tableView:(UITableView *)tableView styleCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath item:(id)item;

@end