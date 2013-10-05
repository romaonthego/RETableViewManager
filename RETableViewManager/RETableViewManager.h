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
#import <REValidation/REValidation.h>
#import "RECommonFunctions.h"
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
#import "RETableViewPickerCell.h"
#import "REBoolItem.h"
#import "RERadioItem.h"
#import "RETextItem.h"
#import "RELongTextItem.h"
#import "RENumberItem.h"
#import "RECreditCardItem.h"
#import "REFloatItem.h"
#import "REDateTimeItem.h"
#import "REMultipleChoiceItem.h"
#import "REPickerItem.h"
#import "RESegmentedItem.h"
#import "REInlineDatePickerItem.h"
#import "REInlinePickerItem.h"

@protocol RETableViewManagerDelegate;

/**
 `RETableViewManager` allows to manage the content of any `UITableView` with ease, both forms and lists. `RETableViewManager` is built on top of reusable cells technique and provides 
 APIs for mapping any object class to any custom cell subclass.
 
 The general idea is to allow developers to use their own `UITableView` and `UITableViewController` instances (and even subclasses), providing a layer that synchronizes data with the cell appereance.
 It fully implements `UITableViewDelegate` and `UITableViewDataSource` protocols so you don't have to.
 */
@interface RETableViewManager : NSObject <UITableViewDelegate, UITableViewDataSource>

///-----------------------------
/// @name Managing Table View and Sections
///-----------------------------

/**
 The array of sections. See RETableViewSection reference for details.
 */
@property (strong, readonly, nonatomic) NSArray *sections;

/**
 The `UITableView` that needs to be managed using this `RETableViewManager`.
 */
@property (weak, readwrite, nonatomic) UITableView *tableView;

///-----------------------------
/// @name Creating and Initializing a RETableViewManager
///-----------------------------

/**
 Initialize a table view manager object for a specific `UITableView` and specify the delegate object.
 
 @param tableView The `UITableView` that needs to be managed.
 @param delegate The delegate (RETableViewManagerDelegate) object for the table view manager.
 @return The pointer to the instance, or nil if initialization failed.
 */
- (id)initWithTableView:(UITableView *)tableView delegate:(id<RETableViewManagerDelegate>)delegate;

/**
 Initialize a table view manager object for a specific `UITableView`.
 
 @param tableView The UITableView that needs to be managed.
 @return The pointer to the instance, or `nil` if initialization failed.
 */
- (id)initWithTableView:(UITableView *)tableView;

///-------------------------------------------
/// @name Managing the Delegate
///-------------------------------------------

/**
 The object that acts as the delegate of the receiving table view.
 */
@property (assign, readwrite, nonatomic) id<RETableViewManagerDelegate> delegate;

///-----------------------------
/// @name Managing Custom Cells
///-----------------------------

/**
 The array of pairs of items / cell classes.
 */
@property (strong, readwrite, nonatomic) NSMutableDictionary *registeredClasses;

/**
 For each custom item class that the manager will use, register a cell class.
 
 @param objectClass The object class to be associated with a cell class.
 @param identifier The cell class identifier.
 */
- (void)registerClass:(NSString *)objectClass forCellWithReuseIdentifier:(NSString *)identifier;

/**
 For each custom item class that the manager will use, register a cell class.
 
 @param objectClass The object class to be associated with a cell class.
 @param identifier The cell class identifier.
 @param bundle The resource gbundle.
 */
- (void)registerClass:(NSString *)objectClass forCellWithReuseIdentifier:(NSString *)identifier bundle:(NSBundle *)bundle;

/**
 Returns cell class at specified index path.
 
 @param indexPath The index path of cell.
 */
- (Class)classForCellAtIndexPath:(NSIndexPath *)indexPath;

/**
 Returns cell class at the keyed subscript.
 
 @param key The keyed subscript.
 @return The cell class the keyed subscript.
 */
- (id)objectAtKeyedSubscript:(id <NSCopying>)key;

/**
 Sets a cell class for the keyed subscript.
 
 @param obj The cell class to set for the keyed subscript.
 @param key The keyed subscript.
 */
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

///-----------------------------
/// @name Setting Style
///-----------------------------

/**
 The object that provides styling for `UITableView`. See RETableViewCellStyle reference for details.
 */
@property (strong, readwrite, nonatomic) RETableViewCellStyle *style;

///-----------------------------
/// @name Adding sections
///-----------------------------

/**
 Inserts a given section at the end of the table view.
 
 @param section The section to add to the end of the table view. This value must not be `nil`.
 */
- (void)addSection:(RETableViewSection *)section;

/**
 Adds the sections contained in another given sections array to the end of the table view.
 
 @param array An array of sections to add to the end of the table view.
 */
- (void)addSectionsFromArray:(NSArray *)array;

/**
 Inserts a given section into the table view at a given index.
 
 @param section The section to add to the table view. This value must not be nil.
 @param index The index in the sections array at which to insert section. This value must not be greater than the count of sections in the table view.
 */
- (void)insertSection:(RETableViewSection *)section atIndex:(NSUInteger)index;

/**
 Inserts the sections in the provided array into the table view at the specified indexes.
 
 @param sections An array of sections to insert into the table view.
 @param indexes The indexes at which the sections in sections should be inserted. The count of locations in indexes must equal the count of sections.
 */
- (void)insertSections:(NSArray *)sections atIndexes:(NSIndexSet *)indexes;

///-----------------------------
/// @name Removing Sections
///-----------------------------

/**
 Removes all occurrences in the table view of a given section.
 
 @param section The section to remove from the table view.
 */
- (void)removeSection:(RETableViewSection *)section;

/**
 Empties the table view of all its sections.
 
 */
- (void)removeAllSections;

/**
 Removes all occurrences of section within the specified range in the table view.
 
 @param section The section to remove from the table view within range.
 @param range The range in the table view from which to remove section.
 */
- (void)removeSectionIdenticalTo:(RETableViewSection *)section inRange:(NSRange)range;

/**
 Removes all occurrences of a given section in the sections array.
 
 @param section The section to remove from the sections array.
 */
- (void)removeSectionIdenticalTo:(RETableViewSection *)section;

/**
 Removes from the table view the sections in another given array.
 
 @param otherArray An array containing the sections to be removed from the table view.
 */
- (void)removeSectionsInArray:(NSArray *)otherArray;

/**
 Removes from the table view each of the sections within a given range.
 
 @param range The range of the sections to remove from the table view.
 */
- (void)removeSectionsInRange:(NSRange)range;

/**
 Removes all occurrences within a specified range in the table view of a given section.
 
 @param section The section to remove from the table view.
 @param range The range from which to remove section.
 */
- (void)removeSection:(RETableViewSection *)section inRange:(NSRange)range;

/**
 Removes the section with the highest-valued index in the table view.
 
 */
- (void)removeLastSection;

/**
 Removes the section at index.
 
 @param index The index from which to remove the section in the table view. The value must not exceed the bounds of the table view sections.
 */
- (void)removeSectionAtIndex:(NSUInteger)index;

/**
 Removes the sections at the specified indexes from the table view.
 
 @param indexes The indexes of the sections to remove from the table view. The locations specified by indexes must lie within the bounds of the table view sections.
 */
- (void)removeSectionsAtIndexes:(NSIndexSet *)indexes;

///-----------------------------
/// @name Replacing Sections
///-----------------------------

/**
 Replaces the section at index with `section`.
 
 @param index The index of the section to be replaced. This value must not exceed the bounds of the table view sections.
 @param section The section with which to replace the section at index `index` in the sections array. This value must not be `nil`.
 */
- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(RETableViewSection *)section;

/**
 Replaces the sections in the table view with all of the sections from a given array.
 
 @param otherArray The array of sections from which to select replacements for the sections.
 */
- (void)replaceSectionsWithSectionsFromArray:(NSArray *)otherArray;

/**
 Replaces the sections in the table view at specified locations specified with the sections from a given array.
 
 @param indexes The indexes of the sections to be replaced.
 @param sections The sections with which to replace the sections in the table view at the indexes specified by indexes. The count of locations in indexes must equal the count of sections.
 */
- (void)replaceSectionsAtIndexes:(NSIndexSet *)indexes withSections:(NSArray *)sections;

/**
 Replaces the sections in the table view by one given range with the sections in another array specified by another range.
 
 @param range The range of sections to replace in (or remove from) the table view.
 @param otherArray The array of sections from which to select replacements for the sections in range.
 @param otherRange The range of sections to select from otherArray as replacements for the sections in range.
 */
- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray *)otherArray range:(NSRange)otherRange;

/**
 Replaces the sections in the table view specified by a given range with all of the sections from a given array.
 
 @param range The range of sections to replace in (or remove from) the table view.
 @param otherArray The array of sections from which to select replacements for the sections in range.
 */
- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray *)otherArray;

///-----------------------------
/// @name Rearranging Sections
///-----------------------------

/**
 Exchanges the sections in the table view at given indices.
 
 @param idx1 The index of the section with which to replace the section at index idx2.
 @param idx2 The index of the section with which to replace the section at index idx1.
 */
- (void)exchangeSectionAtIndex:(NSUInteger)idx1 withSectionAtIndex:(NSUInteger)idx2;

/**
 Sorts the sections in ascending order as defined by the comparison function compare.
 
 @param compare The comparison function to use to compare two sections at a time.
 @param context The context argument to pass to the compare function.
 */
- (void)sortSectionsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context;

/**
 Sorts the sections in ascending order, as determined by the comparison method specified by a given selector.
 
 @param comparator A selector that specifies the comparison method to use to compare sections in the table view.
 */
- (void)sortSectionsUsingSelector:(SEL)comparator;

///-----------------------------
/// @name Checking for Validation Errors
///-----------------------------

@property (strong, readonly, nonatomic) NSArray *errors;

@end


/**
 The delegate of a `RETableViewManager` object can adopt the `RETableViewManagerDelegate` protocol. Optional methods of the protocol allow the delegate to manage cells.
 */
@protocol RETableViewManagerDelegate <UITableViewDelegate>

@optional

/*
 Tells the delegate the table view is about to layout a cell for a particular row.
 
 @param tableView The table-view object informing the delegate of this impending event.
 @param cell A table-view cell object that tableView is going to use when drawing the row.
 @param indexPath An index path locating the row in tableView.
 */
- (void)tableView:(UITableView *)tableView willLayoutCellSubviews:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 Tells the delegate the table view is about to create a cell for a particular row and make it reusable.
 
 @param tableView The table-view object informing the delegate of this impending event.
 @param cell A table-view cell object that tableView is going to create.
 @param indexPath An index path locating the row in tableView.
 */
- (void)tableView:(UITableView *)tableView willLoadCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 Tells the delegate the table view has created a cell for a particular row and made it reusable.
 
 @param tableView The table-view object informing the delegate of this event.
 @param cell A table-view cell object that tableView has created.
 @param indexPath An index path locating the row in tableView.
 */
- (void)tableView:(UITableView *)tableView didLoadCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
