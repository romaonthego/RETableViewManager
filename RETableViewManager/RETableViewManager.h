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

NSUInteger REDeviceSystemMajorVersion();

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
 The `UITableView` that needs to be managed using this `RETableViewManager`.
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

/**
 Returns cell class at specified index path.
 
 @param indexPath The index path of cell.
 */
- (Class)classForCellAtIndexPath:(NSIndexPath *)indexPath;

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

/**
 Adds the sections contained in another given sections array to the end of the receiving sections array’s content.
 
 @param array An array of sections to add to the end of the receiving sections array’s content.
 */
- (void)addSectionsFromArray:(NSArray *)array;

/**
 Inserts a given section into the sections array's contents at a given index.
 
 @param section The section to add to the sections array's content. This value must not be nil.
 @param index The index in the sections array at which to insert section. This value must not be greater than the count of elements in the sections array.
 */
- (void)insertSection:(RETableViewSection *)section atIndex:(NSUInteger)index;

/**
 Inserts the sections in the provided sections array into the receiving sections array at the specified indexes.
 
 @param sections An array of sections to insert into the receiving sections array.
 @param indexes The indexes at which the sections in sections should be inserted. The count of locations in indexes must equal the count of sections.
 */
- (void)insertSections:(NSArray *)sections atIndexes:(NSIndexSet *)indexes;

///-----------------------------
/// @name Removing Sections
///-----------------------------

/**
 Removes all occurrences in the sections array of a given section.
 
 @param section The section to remove from the sections array.
 */
- (void)removeSection:(RETableViewSection *)section;

/**
 Empties the sections array of all its elements.
 
 */
- (void)removeAllSections;

/**
 Removes all occurrences of section within the specified range in the sections array.
 
 @param section The section to remove from the sections array within range.
 @param range The range in the sections array from which to remove section.
 */
- (void)removeSectionIdenticalTo:(RETableViewSection *)section inRange:(NSRange)range;

/**
 Removes all occurrences of a given section in the sections array.
 
 @param section The section to remove from the sections array.
 */
- (void)removeSectionIdenticalTo:(RETableViewSection *)section;

/**
 Removes from the receiving array the objects in another given array.
 
 @param otherArray An array containing the sections to be removed from the receiving sections array.
 */
- (void)removeSectionsInArray:(NSArray *)otherArray;

/**
 Removes from the sections array each of the sections within a given range.
 
 @param range The range of the sections to remove from the sections array.
 */
- (void)removeSectionsInRange:(NSRange)range;

/**
 Removes all occurrences within a specified range in the array of a given object.
 
 @param section The section to remove from the sections array's content.
 @param range The range from which to remove section.
 */
- (void)removeSection:(RETableViewSection *)section inRange:(NSRange)range;

/**
 Removes the section with the highest-valued index in the sections array
 
 */
- (void)removeLastSection;

/**
 Removes the section at index.
 
 @param index The index from which to remove the section in the sections array. The value must not exceed the bounds of the sections array.
 */
- (void)removeSectionAtIndex:(NSUInteger)index;

/**
 Removes the objects at the specified indexes from the array.
 
 @param indexes The indexes of the sections to remove from the sections array. The locations specified by indexes must lie within the bounds of the sections array.
 */
- (void)removeSectionsAtIndexes:(NSIndexSet *)indexes;

///-----------------------------
/// @name Replacing Sections
///-----------------------------

/**
 Replaces the section at index with section.
 
 @param index The index of the section to be replaced. This value must not exceed the bounds of the sections array.
 @param section The section with which to replace the section at index index in the array. This value must not be `nil`.
 */
- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(RETableViewSection *)section;

/**
 Replaces the sections in the receiving sections array at specified locations specified with the objects from a given sections array.
 
 @param indexes The indexes of the sections to be replaced.
 @param sections The sections with which to replace the sections in the receiving sections array at the indexes specified by indexes. The count of locations in indexes must equal the count of sections.
 */
- (void)replaceSectionsAtIndexes:(NSIndexSet *)indexes withSections:(NSArray *)sections;

/**
 Replaces the objects in the receiving array specified by one given range with the objects in another array specified by another range.
 
 @param range The range of sections to replace in (or remove from) the receiving sections array.
 @param otherArray The array of sections from which to select replacements for the sections in range.
 @param otherRange The range of sections to select from otherArray as replacements for the sections in range.
 */
- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray *)otherArray range:(NSRange)otherRange;

/**
 Replaces the sections in the receiving sections array specified by a given range with all of the objects from a given array.
 
 @param range The range of sections to replace in (or remove from) the sections array.
 @param otherArray The array of sections from which to select replacements for the sections in range.
 */
- (void)replaceSectionsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray;

///-----------------------------
/// @name Rearranging Content
///-----------------------------

/**
 Exchanges the sections in the section array at given indices.
 
 @param idx1 The index of the section with which to replace the section at index idx2.
 @param idx2 The index of the section with which to replace the section at index idx1.
 */
- (void)exchangeSectionAtIndex:(NSUInteger)idx1 withSectionAtIndex:(NSUInteger)idx2;

/**
 Sorts the sections array’s elements in ascending order as defined by the comparison function compare.
 
 @param compare The comparison function to use to compare two elements at a time.
 @param context The context argument to pass to the compare function.
 */
- (void)sortSectionsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context;

/**
 Sorts the sections array’s elements in ascending order, as determined by the comparison method specified by a given selector.
 
 @param comparator A selector that specifies the comparison method to use to compare elements in the sections array.
 */
- (void)sortSectionsUsingSelector:(SEL)comparator;

///-----------------------------
/// @name Other
///-----------------------------

/**
 Returns object at the keyed subscript.
 
 @param key The keyed subscript.
 @return The object at the keyed subscript.
 */
- (id)objectAtKeyedSubscript:(id <NSCopying>)key;

/**
 Sets an object for the keyed subscript.
 
 @param obj The object to set for the keyed subscript.
 @param key The keyed subscript.
 */
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

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
