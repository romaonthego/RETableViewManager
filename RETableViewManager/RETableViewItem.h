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
#import <REValidation/REValidation.h>
#import "RETableViewCellStyle.h"

@class RETableViewSection;

@interface RETableViewItem : NSObject

@property (copy, readwrite, nonatomic) NSString *title;
@property (strong, readwrite, nonatomic) UIImage *image;
@property (strong, readwrite, nonatomic) UIImage *highlightedImage;
@property (assign, readwrite, nonatomic) NSTextAlignment textAlignment;
@property (weak, readwrite, nonatomic) RETableViewSection *section;
@property (copy, readwrite, nonatomic) NSString *detailLabelText;
@property (assign, readwrite, nonatomic) UITableViewCellStyle style;
@property (assign, readwrite, nonatomic) UITableViewCellSelectionStyle selectionStyle;
@property (assign, readwrite, nonatomic) UITableViewCellAccessoryType accessoryType;
@property (assign, readwrite, nonatomic) UITableViewCellEditingStyle editingStyle;
@property (strong, readwrite, nonatomic) UIView *accessoryView;
@property (copy, readwrite, nonatomic) void (^selectionHandler)(id item);
@property (copy, readwrite, nonatomic) void (^accessoryButtonTapHandler)(id item);
@property (copy, readwrite, nonatomic) void (^insertionHandler)(id item);
@property (copy, readwrite, nonatomic) void (^deletionHandler)(id item);
@property (copy, readwrite, nonatomic) void (^deletionHandlerWithCompletion)(id item, void (^)(void));
@property (copy, readwrite, nonatomic) BOOL (^moveHandler)(id item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
@property (copy, readwrite, nonatomic) void (^moveCompletionHandler)(id item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
@property (copy, readwrite, nonatomic) void (^cutHandler)(id item);
@property (copy, readwrite, nonatomic) void (^copyHandler)(id item);
@property (copy, readwrite, nonatomic) void (^pasteHandler)(id item);
@property (assign, readwrite, nonatomic) CGFloat cellHeight;
@property (copy, readwrite, nonatomic) NSString *cellIdentifier;

// Action bar
@property (copy, readwrite, nonatomic) void (^actionBarDoneButtonTapHandler)(id item); //handler for done button on ActionBar


// Error validation
//
@property (copy, readwrite, nonatomic) NSString *name;
@property (strong, readwrite, nonatomic) NSArray *validators;
@property (strong, readonly, nonatomic) NSArray *errors;

+ (instancetype)item;
+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(void(^)(RETableViewItem *item))selectionHandler;
+ (instancetype)itemWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(void(^)(RETableViewItem *item))selectionHandler accessoryButtonTapHandler:(void(^)(RETableViewItem *item))accessoryButtonTapHandler;

- (id)initWithTitle:(NSString *)title;
- (id)initWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(void(^)(RETableViewItem *item))selectionHandler;
- (id)initWithTitle:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType selectionHandler:(void(^)(RETableViewItem *item))selectionHandler accessoryButtonTapHandler:(void(^)(RETableViewItem *item))accessoryButtonTapHandler;

- (NSIndexPath *)indexPath;

///-----------------------------
/// @name Manipulating table view row
///-----------------------------

- (void)selectRowAnimated:(BOOL)animated;
- (void)selectRowAnimated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;
- (void)deselectRowAnimated:(BOOL)animated;
- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation;
- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation;

@end
