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
@property (strong, nonatomic) NSMutableArray *items;

@property (copy, nonatomic) NSString *headerTitle;
@property (copy, nonatomic) NSString *footerTitle;

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIView *footerView;

///--------------------------------------------
/// @name Creating and Initializing Sections
///--------------------------------------------
- (id)initWithHeaderTitle:(NSString *)headerTitle;
- (id)initWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;
- (id)initWithHeaderView:(UIView *)headerView;
- (id)initWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView;

+ (id)section;
+ (id)sectionWithHeaderTitle:(NSString *)headerTitle;
+ (id)sectionWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;
+ (id)sectionWithHeaderView:(UIView *)headerView;
+ (id)sectionWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView;

@end

@interface RETableViewSection (REExtendedTableViewSection)

- (id)addItem:(id)item;
- (id)insertItem:(id)item atIndex:(NSUInteger)index;
- (void)addItemsFromArray:(NSArray *)array;
- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (void)removeItem:(id)item inRange:(NSRange)range;
- (void)removeLastItem;
- (void)removeItemAtIndex:(NSUInteger)index;
- (void)replaceItemAtIndex:(NSUInteger)index withItem:(id)item;
- (void)removeItem:(id)item;
- (void)removeAllItems;
- (void)removeItemIdenticalTo:(id)item inRange:(NSRange)range;
- (void)removeItemIdenticalTo:(id)item;
- (void)removeItemsInArray:(NSArray *)otherArray;
- (void)removeItemsInRange:(NSRange)range;
- (void)replaceItemsInRange:(NSRange)range withItemsFromArray:(NSArray *)otherArray range:(NSRange)otherRange;
- (void)replaceItemsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray;
- (void)sortItemsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context;
- (void)sortItemsUsingSelector:(SEL)comparator;
- (void)insertItems:(NSArray *)items atIndexes:(NSIndexSet *)indexes;
- (void)removeItemsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceItemsAtIndexes:(NSIndexSet *)indexes withItems:(NSArray *)items;

@end