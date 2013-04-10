//
// RETableViewItem.h
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

#import <Foundation/Foundation.h>
#import "RETableViewCellStyle.h"

@class RETableViewSection;

@interface RETableViewItem : NSObject

@property (copy, readwrite, nonatomic) NSString *title;
@property (assign, readwrite, nonatomic) NSTextAlignment textAlignment;
@property (weak, readwrite, nonatomic) RETableViewSection *section;
@property (copy, readwrite, nonatomic) NSString *detailLabelText;
@property (assign, readwrite, nonatomic) UITableViewCellStyle cellStyle;
@property (assign, readwrite, nonatomic) UITableViewCellAccessoryType accessoryType;
@property (strong, readwrite, nonatomic) UIView *accessoryView;
@property (copy, readwrite, nonatomic) void (^selectionHandler)(id item);
@property (copy, readwrite, nonatomic) void (^accessoryButtonTapHandler)(id item);

+ (id)item;
+ (id)itemWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(void(^)(RETableViewItem *item))selectionHandler;
+ (id)itemWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(void(^)(RETableViewItem *item))selectionHandler accessoryButtonTapHandler:(void(^)(RETableViewItem *item))accessoryButtonTapHandler;

- (id)initWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(void(^)(RETableViewItem *item))selectionHandler;
- (id)initWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(void(^)(RETableViewItem *item))selectionHandler accessoryButtonTapHandler:(void(^)(RETableViewItem *item))accessoryButtonTapHandler;

- (NSIndexPath *)indexPath;

@end
