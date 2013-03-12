//
// RETableViewSection.m
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

#import "RETableViewSection.h"

@implementation RETableViewSection

#pragma mark -
#pragma mark Creating and Initializing Sections

- (id)init
{
    self = [super init];
    if (!self)
        return nil;
    
    _items = [[NSMutableArray alloc] init];
    
    return self;
}

- (id)initWithHeaderTitle:(NSString *)headerTitle
{
    return [self initWithHeaderTitle:headerTitle footerTitle:nil];
}

- (id)initWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    self = [self init];
    if (!self)
        return nil;
    
    self.headerTitle = headerTitle;
    self.footerTitle = footerTitle;
    
    return self;
}

- (id)initWithHeaderView:(UIView *)headerView
{
    return [self initWithHeaderView:headerView footerView:nil];
}

- (id)initWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView
{
    self = [self init];
    if (!self)
        return nil;
    
    self.headerView = headerView;
    self.footerView = footerView;
    
    return self;
}

/*
 * Static initialization methods
 *
 */

+ (id)section
{
    return [[self alloc] init];
}

+ (id)sectionWithHeaderTitle:(NSString *)headerTitle
{
    return [[self alloc ] initWithHeaderTitle:headerTitle];
}

+ (id)sectionWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    return [[self alloc] initWithHeaderTitle:headerTitle footerTitle:footerTitle];
}

+ (id)sectionWithHeaderView:(UIView *)headerView
{
    return [[self alloc] initWithHeaderView:headerView footerView:nil];
}

+ (id)sectionWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView
{
    return [[self alloc] initWithHeaderView:headerView footerView:footerView];
}


@end

#pragma mark -
#pragma mark Managing items

@implementation RETableViewSection (REExtendedTableViewSection)

- (id)addItem:(id)item
{
    [_items addObject:item];
    return item;
}

- (id)insertItem:(id)item atIndex:(NSUInteger)index
{
    [_items insertObject:item atIndex:index];
    return item;
}

- (void)addItemsFromArray:(NSArray *)array
{
    [_items addObjectsFromArray:array];
}

- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
    [_items exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

- (void)removeItem:(id)item inRange:(NSRange)range
{
    [_items removeObject:item inRange:range];
}

- (void)removeLastItem
{
    [_items removeLastObject];
}

- (void)removeItemAtIndex:(NSUInteger)index
{
    [_items removeObjectAtIndex:index];
}

- (void)replaceItemAtIndex:(NSUInteger)index withItem:(id)item
{
    [_items replaceObjectAtIndex:index withObject:item];
}

- (void)removeItem:(id)item
{
    [_items removeObject:item];
}

- (void)removeAllItems
{
    [_items removeAllObjects];
}

- (void)removeItemIdenticalTo:(id)item inRange:(NSRange)range
{
    [_items removeObjectIdenticalTo:item inRange:range];
}

- (void)removeItemIdenticalTo:(id)item
{
    [_items removeObjectIdenticalTo:item];
}

- (void)removeItemsInArray:(NSArray *)otherArray
{
    [_items removeObjectsInArray:otherArray];
}

- (void)removeItemsInRange:(NSRange)range
{
    [_items removeObjectsInRange:range];
}

- (void)replaceItemsInRange:(NSRange)range withItemsFromArray:(NSArray *)otherArray range:(NSRange)otherRange
{
    [_items replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
}

- (void)replaceItemsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray
{
    [_items replaceObjectsInRange:range withObjectsFromArray:otherArray];
}

- (void)sortItemsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context
{
    [_items sortUsingFunction:compare context:context];
}

- (void)sortItemsUsingSelector:(SEL)comparator
{
    [_items sortUsingSelector:comparator];
}

- (void)insertItems:(NSArray *)items atIndexes:(NSIndexSet *)indexes
{
    [_items insertObjects:items atIndexes:indexes];
}

- (void)removeItemsAtIndexes:(NSIndexSet *)indexes
{
    [_items removeObjectsAtIndexes:indexes];
}

- (void)replaceItemsAtIndexes:(NSIndexSet *)indexes withItems:(NSArray *)items
{
    [_items replaceObjectsAtIndexes:indexes withObjects:items];
}

@end
