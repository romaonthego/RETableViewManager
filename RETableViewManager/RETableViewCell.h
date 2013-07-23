//
// RETableViewCell.h
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
#import "REActionBar.h"

@class RETableViewManager;
@class RETableViewItem;

typedef enum _RETableViewCellType {
    RETableViewCellTypeFirst,
    RETableViewCellTypeMiddle,
    RETableViewCellTypeLast,
    RETableViewCellTypeSingle,
    RETableViewCellTypeAny
} RETableViewCellType;

/**
 The `RETableViewCell` class defines the attributes and behavior of the cells that appear in `UITableView` objects.
 
 */
@interface RETableViewCell : UITableViewCell <REActionBarDelegate>

///-----------------------------
/// @name Accessing Table View and Table View Manager
///-----------------------------

@property (weak, readwrite, nonatomic) UITableView *parentTableView;
@property (weak, readwrite, nonatomic) RETableViewManager *tableViewManager;

///-----------------------------
/// @name Managing Cell Appearance
///-----------------------------

@property (strong, readonly, nonatomic) UIImageView *backgroundImageView;
@property (strong, readonly, nonatomic) UIImageView *selectedBackgroundImageView;
@property (strong, readwrite, nonatomic) REActionBar *actionBar;

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager;

- (void)updateActionBarNavigationControl;

///-----------------------------
/// @name Accessing Row and Section
///-----------------------------

@property (assign, readwrite, nonatomic) NSInteger row;
@property (assign, readwrite, nonatomic) NSInteger sectionIndex;
@property (weak, readwrite, nonatomic) RETableViewSection *section;
@property (strong, readwrite, nonatomic) RETableViewItem *item;
@property (assign, readonly, nonatomic) RETableViewCellType cellType;
@property (strong, readonly, nonatomic) UIResponder *responder;
@property (strong, readonly, nonatomic) NSIndexPath *indexPathForPreviousResponder;
@property (strong, readonly, nonatomic) NSIndexPath *indexPathForNextResponder;

+ (BOOL)canFocusWithItem:(RETableViewItem *)item;

///-----------------------------
/// @name Handling Cell Events
///-----------------------------

- (void)cellDidLoad;
- (void)cellWillAppear;
- (void)cellDidDisappear;

@end
