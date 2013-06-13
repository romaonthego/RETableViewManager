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
#import "RETableViewBoolCell.h"
#import "RETableViewCreditCardCell.h"
#import "RETableViewTextCell.h"
#import "RETableViewNumberCell.h"
#import "RETableViewFloatCell.h"
#import "RETableViewDateTimeCell.h"
#import "RETableViewLongTextCell.h"
#import "RETableViewOptionCell.h"

#import "REBoolItem.h"
#import "RERadioItem.h"
#import "RETextItem.h"
#import "RELongTextItem.h"
#import "RENumberItem.h"
#import "RECreditCardItem.h"
#import "REFloatItem.h"
#import "REDateTimeItem.h"
#import "REMultipleChoiceItem.h"

@protocol RETableViewManagerDelegate;

/**
 `RETableViewManager` allows to manage content of `UITableView` with ease, both forms and lists. In its core `RETableViewManager` supports reusable cells based on corresponding data object class.
 
 The general idea is to allow developers use their own `UITableView` and UITableViewController instances, providing a layer that synchronizes data with cell appereance.
 */
@interface RETableViewManager : NSObject <UITableViewDelegate, UITableViewDataSource>

/**
 The aggregate collection of sections. See RETableViewSection reference for details.
 */
@property (strong, readwrite, nonatomic) NSMutableArray *sections;

/**
 The `UITableView` that needs to be managed.
 */
@property (weak, readwrite, nonatomic) UITableView *tableView;

///-----------------------------
/// @name Creating and Initializing a RETableViewManager
///-----------------------------

/**
 Initialize a table view manager object for a specific UITableView and specify the delegate object.
 
 @param tableView The UITableView that needs to be managed.
 @param delegate The delegate (RETableViewManagerDelegate) object for the table view manager.
 @return The pointer to the instance, or nil if initialization failed.
 */
- (id)initWithTableView:(UITableView *)tableView delegate:(id<RETableViewManagerDelegate>)delegate;

/**
 Initialize a table view manager object for a specific UITableView.
 
 @param tableView The UITableView that needs to be managed.
 @return The pointer to the instance, or nil if initialization failed.
 */
- (id)initWithTableView:(UITableView *)tableView;

///-------------------------------------------
/// @name Managing the Delegate
///-------------------------------------------

/**
 The object that acts as the delegate of the receiving table view.
 */
@property (assign, readwrite, nonatomic) id<RETableViewManagerDelegate>delegate;

///-----------------------------
/// @name Managing Object Mappings
///-----------------------------

/**
 The aggregate collection of item and class mappings within this table view manager.
 */
@property (strong, readwrite, nonatomic) NSMutableDictionary *mapping;

- (void)registerClass:(NSString *)objectClass forCellWithReuseIdentifier:(NSString *)identifier;

///-----------------------------
/// @name Setting default style
///-----------------------------

/**
 The object that provides styling for `UITableView`. See RETableViewCellStyle reference for details.
 */
@property (strong, readwrite, nonatomic) RETableViewCellStyle *style;

///-----------------------------
/// @name Adding sections
///-----------------------------

/**
 Inserts a given section at the end of the sections array.
 
 @param section The section to add to the end of the sections array's content. This value must not be `nil`.
 */
- (void)addSection:(RETableViewSection *)section;
- (void)addSectionsFromArray:(NSArray *)array;
- (void)insertSection:(RETableViewSection *)section atIndex:(NSUInteger)index;
- (void)insertSections:(NSArray *)sections atIndexes:(NSIndexSet *)indexes;

///-----------------------------
/// @name Removing Sections
///-----------------------------

- (void)removeSection:(RETableViewSection *)section;
- (void)removeAllSections;
- (void)removeSectionIdenticalTo:(RETableViewSection *)section inRange:(NSRange)range;
- (void)removeSectionIdenticalTo:(RETableViewSection *)section;
- (void)removeSectionsInArray:(NSArray *)otherArray;
- (void)removeSectionsInRange:(NSRange)range;
- (void)removeSection:(RETableViewSection *)section inRange:(NSRange)range;
- (void)removeLastSection;
- (void)removeSectionAtIndex:(NSUInteger)index;
- (void)removeSectionsAtIndexes:(NSIndexSet *)indexes;

///-----------------------------
/// @name Replacing Sections
///-----------------------------

- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(RETableViewSection *)section;
- (void)replaceSectionsAtIndexes:(NSIndexSet *)indexes withSections:(NSArray *)sections;
- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray *)otherArray range:(NSRange)otherRange;
- (void)replaceSectionsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray;

///-----------------------------
/// @name Rearranging Content
///-----------------------------

- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (void)sortSectionsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context;
- (void)sortSectionsUsingSelector:(SEL)comparator;

///-----------------------------
/// @name Other
///-----------------------------
- (Class)classForCellAtIndexPath:(NSIndexPath *)indexPath;

@end


/**
 The delegate of a `RETableViewManager` object can adopt the `RETableViewManagerDelegate` protocol. Optional methods of the protocol allow the delegate to manage selections and perform other actions.
 */
@protocol RETableViewManagerDelegate <NSObject>

@optional

- (void)tableView:(UITableView *)tableView styleCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView cellWillLayoutSubviews:(UITableViewCell *)cell;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath item:(id)items;
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath item:(id)items;

@end