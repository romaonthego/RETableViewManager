//
// RETableViewSection.h
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

@class RETableViewManager;
@class RETableViewCellStyle;

extern CGFloat const RETableViewSectionHeaderHeightAutomatic;
extern CGFloat const RETableViewSectionFooterHeightAutomatic;

/**
 Table view section.
 */
@interface RETableViewSection : NSObject

/**
 An array of section items (rows).
 */
@property (strong, readonly, nonatomic) NSArray *items;

/**
 The title of the header of the specified section of the table view.
 */
@property (copy, readwrite, nonatomic) NSString *headerTitle;

/**
 The title of the footer of the specified section of the table view.
 */
@property (copy, readwrite, nonatomic) NSString *footerTitle;

/**
 The height of the header of the specified section of the table view.
 */
@property (assign, readwrite, nonatomic) CGFloat headerHeight;

/**
 The height of the footer of the specified section of the table view.
 */
@property (assign, readwrite, nonatomic) CGFloat footerHeight;

/**
 A view object to display in the header of the specified section of the table view.
 */
@property (strong, readwrite, nonatomic) UIView *headerView;

/**
 A view object to display in the footer of the specified section of the table view.
 */
@property (strong, readwrite, nonatomic) UIView *footerView;

/**
 The table view manager of this section.
 */
@property (weak, readwrite, nonatomic) RETableViewManager *tableViewManager;

/**
 Section index in UITableView.
 */
@property (assign, readonly, nonatomic) NSUInteger index;

/**
 Section index title.
 */
@property (copy, readwrite, nonatomic) NSString *indexTitle;

/**
 Returns the width of the longest title in the section.
 
 @param font A base font to use in calculations.
 @return width.
 */
- (CGFloat)maximumTitleWidthWithFont:(UIFont *)font;

///-----------------------------
/// @name Creating and Initializing a RETableViewSection
///-----------------------------

/**
 Creates and returns a new section.
 @return A new section.
 */
+ (instancetype)section;

/**
 Creates and returns a new section with predefined header title.
 @param headerTitle A header title.
 @return A new section with defined header title.
 */
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle;

/**
 Creates and returns a new section with predefined header and footer titles.
 @param headerTitle A header title.
 @param footerTitle A footer title.
 @return A new section with header and footer titles.
 */
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;

/**
 Creates and returns a new section containing a header view.
 @param headerView A header view.
 @return A new section containing a header view.
 */
+ (instancetype)sectionWithHeaderView:(UIView *)headerView;

/**
 Creates and returns a new section containing header and footer views.
 @param headerView A header view.
 @param footerView A footer view.
 @return A new section containing header and footer views.
 */
+ (instancetype)sectionWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView;

/**
 Initializes a newly allocated section and sets header title.
 @param headerTitle A header title.
 @return A new section initialized with a header title. 
 */
- (id)initWithHeaderTitle:(NSString *)headerTitle;

/**
 Initializes a newly allocated section with header and footer titles.
 @param headerTitle A header title.
 @param footerTitle A footer title.
 @return A new section initialized with header and footer titles.
 */
- (id)initWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;

/**
 Initializes a newly allocated section containing a header view.
 @param headerView A header view.
 @return A new section initialized containing a header view.
 */
- (id)initWithHeaderView:(UIView *)headerView;

/**
 Initializes a newly allocated section containing header and footer views.
 @param headerView A header view.
 @param footerView A footer view.
 @return A new section initialized with header and footer views.
 */
- (id)initWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView;

///-----------------------------
/// @name Styling
///-----------------------------

/**
 The object that provides styling for the section. See RETableViewCellStyle reference for details.
 */
@property (strong, readwrite, nonatomic) RETableViewCellStyle *style;

///-----------------------------
/// @name Adding Items
///-----------------------------

/**
 Inserts a given item at the end of the section.
 @param item The item to add to the end of the section. This value must not be `nil`.
 @return The item.
 */
- (void)addItem:(id)item;

/**
 Adds the items contained in another given array to the end of the section.
 
 @param array An array of items to add to the end of the section.
 */
- (void)addItemsFromArray:(NSArray *)array;

/**
 Inserts a given item into the section at a given index.
 
 @param item The item to add to the section. This value must not be nil.
 @param index The index in the section at which to insert item. This value must not be greater than the count of items in the section.
 */
- (void)insertItem:(id)item atIndex:(NSUInteger)index;

/**
 Inserts the items in the provided items array into the section at the specified indexes.
 
 @param items An array of items to insert into the section.
 @param indexes The indexes at which the items should be inserted.
 */
- (void)insertItems:(NSArray *)items atIndexes:(NSIndexSet *)indexes;

///-----------------------------
/// @name Removing Items
///-----------------------------

/**
 Removes all occurrences in the section of a given item.
 
 @param item The item to remove from the section.
 */
- (void)removeItem:(id)item;

/**
 Empties the section of all its items.
 
 */
- (void)removeAllItems;

/**
 Removes all occurrences of item within the specified range in the section.
 
 @param item The item to remove from the section within range.
 @param range The range in the section from which to remove section.
 */
- (void)removeItemIdenticalTo:(id)item inRange:(NSRange)range;

/**
 Removes all occurrences of a given item in the section.
 
 @param item The section to remove from the section.
 */
- (void)removeItemIdenticalTo:(id)item;

/**
 Removes from the section the items in another given array.
 
 @param otherArray An array containing the items to be removed from the section.
 */
- (void)removeItemsInArray:(NSArray *)otherArray;

/**
 Removes from the section each of the items within a given range.
 
 @param range The range of the items to remove from the section.
 */
- (void)removeItemsInRange:(NSRange)range;

/**
 Removes all occurrences within a specified range in the section of a given item.
 
 @param item The item to remove from the section.
 @param range The range from which to remove item.
 */
- (void)removeItem:(id)item inRange:(NSRange)range;

/**
 Removes the item with the highest-valued index in the section.
 
 */
- (void)removeLastItem;

/**
 Removes the item at index.
 
 @param index The index from which to remove the item in the section. The value must not exceed the bounds of the section.
 */
- (void)removeItemAtIndex:(NSUInteger)index;

/**
 Removes the items at the specified indexes from the section.
 
 @param indexes The indexes of the items to remove from the section. The locations specified by indexes must lie within the bounds of the section.
 */
- (void)removeItemsAtIndexes:(NSIndexSet *)indexes;

///-----------------------------
/// @name Replacing Items
///-----------------------------

/**
 Replaces the item at index with another item.
 
 @param index The index of the item to be replaced. This value must not exceed the bounds of the section.
 @param item The item with which to replace the item at index index in the section. This value must not be `nil`.
 */
- (void)replaceItemAtIndex:(NSUInteger)index withItem:(id)item;

/**
 Replaces the items in the section with all of the items from a given array.
 
 @param otherArray The array of items from which to select replacements for the items.
 */
- (void)replaceItemsWithItemsFromArray:(NSArray *)otherArray;

/**
 Replaces the items in the section at specified locations specified with the items from a given array.
 
 @param indexes The indexes of the items to be replaced.
 @param items The items with which to replace the items in the section at the indexes specified by `indexes`. The count of locations in indexes must equal the count of items.
 */
- (void)replaceItemsAtIndexes:(NSIndexSet *)indexes withItems:(NSArray *)items;

/**
 Replaces the items in the section by one given range with the items in another array specified by another range.
 
 @param range The range of items to replace in (or remove from) the section.
 @param otherArray The array of items from which to select replacements for the items in range.
 @param otherRange The range of items to select from otherArray as replacements for the items in range.
 */
- (void)replaceItemsInRange:(NSRange)range withItemsFromArray:(NSArray *)otherArray range:(NSRange)otherRange;

/**
 Replaces the items in the section specified by a given range with all of the items from a given array.
 
 @param range The range of items to replace in (or remove from) the section.
 @param otherArray The array of items from which to select replacements for the items in range.
 */
- (void)replaceItemsInRange:(NSRange)range withItemsFromArray:(NSArray *)otherArray;

///-----------------------------
/// @name Rearranging Items
///-----------------------------

/**
 Exchanges the items in the section at given indices.
 
 @param idx1 The index of the item with which to replace the item at index idx2.
 @param idx2 The index of the items with which to replace the item at index idx1.
 */
- (void)exchangeItemAtIndex:(NSUInteger)idx1 withItemAtIndex:(NSUInteger)idx2;

/**
 Sorts the items in ascending order as defined by the comparison function compare.
 
 @param compare The comparison function to use to compare two items at a time.
 @param context The context argument to pass to the compare function.
 */
- (void)sortItemsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context;
- (void)sortItemsUsingSelector:(SEL)comparator;

///-----------------------------
/// @name Manipulating table view section
///-----------------------------

/**
 Reloads the `section` using a given animation effect.
 
 @param animation A constant that indicates how the reloading is to be animated
 */
- (void)reloadSectionWithAnimation:(UITableViewRowAnimation)animation;

///-----------------------------
/// @name Checking for Validation Errors
///-----------------------------

@property (strong, readonly, nonatomic) NSArray *errors;

@end