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

@interface RETableViewSection : NSObject

/**
 An array of section items (rows).
 */
@property (strong, readwrite, nonatomic) NSMutableArray *items;

/**
 The title of the header of the specified section of the table view
 */
@property (copy, readwrite, nonatomic) NSString *headerTitle;

/**
 The title of the footer of the specified section of the table view
 */
@property (copy, readwrite, nonatomic) NSString *footerTitle;

/**
 A view object to display in the header of the specified section of the table view.
 */
@property (strong, readwrite, nonatomic) UIView *headerView;

/**
 A view object to display in the footer of the specified section of the table view.
 */
@property (strong, readwrite, nonatomic) UIView *footerView;

@end

@interface RETableViewSection (RETableViewSectionCreation)

///-----------------------------
/// @name Creating and Initializing a RETableViewSection
///-----------------------------

+ (id)section;
+ (id)sectionWithHeaderTitle:(NSString *)headerTitle;
+ (id)sectionWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;
+ (id)sectionWithHeaderView:(UIView *)headerView;
+ (id)sectionWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView;

- (id)initWithHeaderTitle:(NSString *)headerTitle;
- (id)initWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;
- (id)initWithHeaderView:(UIView *)headerView;
- (id)initWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView;

@end

@interface RETableViewSection (REExtendedTableViewSection)

///-----------------------------
/// @name Adding Items
///-----------------------------

- (id)addItem:(id)item;
- (void)addItemsFromArray:(NSArray *)array;
- (id)insertItem:(id)item atIndex:(NSUInteger)index;
- (void)insertItems:(NSArray *)items atIndexes:(NSIndexSet *)indexes;

///-----------------------------
/// @name Removing Items
///-----------------------------

- (void)removeItem:(id)item;
- (void)removeAllItems;
- (void)removeItemIdenticalTo:(id)item inRange:(NSRange)range;
- (void)removeItemIdenticalTo:(id)item;
- (void)removeItemsInArray:(NSArray *)otherArray;
- (void)removeItemsInRange:(NSRange)range;
- (void)removeItem:(id)item inRange:(NSRange)range;
- (void)removeLastItem;
- (void)removeItemAtIndex:(NSUInteger)index;
- (void)removeItemsAtIndexes:(NSIndexSet *)indexes;

///-----------------------------
/// @name Replacing Items
///-----------------------------

- (void)replaceItemAtIndex:(NSUInteger)index withItem:(id)item;
- (void)replaceItemsAtIndexes:(NSIndexSet *)indexes withItems:(NSArray *)items;
- (void)replaceItemsInRange:(NSRange)range withItemsFromArray:(NSArray *)otherArray range:(NSRange)otherRange;
- (void)replaceItemsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray;

///-----------------------------
/// @name Rearranging Content
///-----------------------------

- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (void)sortItemsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context;
- (void)sortItemsUsingSelector:(SEL)comparator;

@end