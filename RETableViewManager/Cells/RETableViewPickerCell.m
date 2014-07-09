//
// RETableViewPickerCell.m
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

#import "RETableViewPickerCell.h"
#import "RETableViewManager.h"
#import "NSString+RETableViewManagerAdditions.h"

@interface RETableViewPickerCell ()

@property (strong, readwrite, nonatomic) UITextField *textField;
@property (strong, readwrite, nonatomic) UILabel *valueLabel;
@property (strong, readwrite, nonatomic) UILabel *placeholderLabel;
@property (strong, readwrite, nonatomic) UIPickerView *pickerView;

@property (assign, readwrite, nonatomic) BOOL enabled;

@end

@implementation RETableViewPickerCell

@synthesize item = _item;

+ (BOOL)canFocusWithItem:(REPickerItem *)item
{
    return !item.inlinePicker;
}

#pragma mark -
#pragma mark Lifecycle

- (void)dealloc {
    if (_item != nil) {
        [_item removeObserver:self forKeyPath:@"enabled"];
    }
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectNull];
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField.inputAccessoryView = self.actionBar;
    self.textField.delegate = self;
    [self addSubview:self.textField];
    
    self.valueLabel = [[UILabel alloc] initWithFrame:CGRectNull];
    self.valueLabel.font = [UIFont systemFontOfSize:17];
    self.valueLabel.backgroundColor = [UIColor clearColor];
    self.valueLabel.textColor = self.detailTextLabel.textColor;
    self.valueLabel.highlightedTextColor = [UIColor whiteColor];
    self.valueLabel.textAlignment = NSTextAlignmentRight;
    self.valueLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:self.valueLabel];
    
    self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectNull];
    self.placeholderLabel.font = [UIFont systemFontOfSize:17];
    self.placeholderLabel.backgroundColor = [UIColor clearColor];
    self.placeholderLabel.textColor = [UIColor lightGrayColor];
    self.placeholderLabel.highlightedTextColor = [UIColor whiteColor];
    [self.contentView addSubview:self.placeholderLabel];
    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}

- (void)cellWillAppear
{
    self.textLabel.text = self.item.title.length == 0 ? @" " : self.item.title;
    self.textField.inputView = self.pickerView;
    
    self.valueLabel.text = self.item.value ? [self.item.value componentsJoinedByString:@", "] : @"";
    self.placeholderLabel.text = self.item.placeholder;
    self.placeholderLabel.hidden = self.valueLabel.text.length > 0;
    
    if (!self.item.title) {
        self.valueLabel.textAlignment = NSTextAlignmentLeft;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    self.valueLabel.textColor = self.item.inlinePickerItem ? [self performSelector:@selector(tintColor) withObject:nil] : self.detailTextLabel.textColor;
#endif
    
    self.enabled = self.item.enabled;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textField.frame = CGRectNull;
    self.textField.alpha = 0;
    
    [self layoutDetailView:self.valueLabel minimumWidth:[self.valueLabel.text re_sizeWithFont:self.valueLabel.font].width];
    [self layoutDetailView:self.placeholderLabel minimumWidth:[self.placeholderLabel.text re_sizeWithFont:self.placeholderLabel.font].width];
    
    if ([self.tableViewManager.delegate respondsToSelector:@selector(tableView:willLayoutCellSubviews:forRowAtIndexPath:)])
        [self.tableViewManager.delegate tableView:self.tableViewManager.tableView willLayoutCellSubviews:self forRowAtIndexPath:[self.tableViewManager.tableView indexPathForCell:self]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected && !self.item.inlinePicker) {
        [self.textField becomeFirstResponder];
        [self.item.options enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([self.item.options objectAtIndex:idx] && [self.item.value objectAtIndex:idx] > 0)
                [self.pickerView selectRow:[[self.item.options objectAtIndex:idx] indexOfObject:[self.item.value objectAtIndex:idx]] inComponent:idx animated:NO];
        }];
    }
    
    if (selected && self.item.inlinePicker && !self.item.inlinePickerItem) {
        [self setSelected:NO animated:NO];
        [self.item deselectRowAnimated:NO];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
        self.valueLabel.textColor = [self performSelector:@selector(tintColor) withObject:nil];
#endif
        self.item.inlinePickerItem = [REInlinePickerItem itemWithPickerItem:self.item];
        [self.section insertItem:self.item.inlinePickerItem atIndex:self.item.indexPath.row + 1];
        [self.tableViewManager.tableView insertRowsAtIndexPaths:@[self.item.inlinePickerItem.indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        if (selected && self.item.inlinePicker && self.item.inlinePickerItem) {
            [self setSelected:NO animated:NO];
            [self.item deselectRowAnimated:NO];
            self.valueLabel.textColor = self.detailTextLabel.textColor;
            NSIndexPath *indexPath = [self.item.inlinePickerItem.indexPath copy];
            [self.section removeItemAtIndex:self.item.inlinePickerItem.indexPath.row];
            self.item.inlinePickerItem = nil;
            [self.tableViewManager.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

- (UIResponder *)responder
{
    return self.textField;
}

- (void)shouldUpdateItemValue
{
    NSMutableArray *value = [NSMutableArray array];
    [self.item.options enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *options = [self.item.options objectAtIndex:idx];
        NSString *valueText = [options objectAtIndex:[self.pickerView selectedRowInComponent:idx]];
        [value addObject:valueText];
    }];
    self.item.value = [value copy];
    self.valueLabel.text = self.item.value ? [self.item.value componentsJoinedByString:@", "] : @"";
    self.placeholderLabel.hidden = self.valueLabel.text.length > 0;
}

#pragma mark -
#pragma mark Handle state

- (void)setItem:(REPickerItem *)item
{
    if (_item != nil) {
        [_item removeObserver:self forKeyPath:@"enabled"];
    }
    
    _item = item;
    
    [_item addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    
    self.userInteractionEnabled = _enabled;
    
    self.textLabel.enabled = _enabled;
    self.textField.enabled = _enabled;
    self.valueLabel.enabled = _enabled;
    self.placeholderLabel.enabled = _enabled;
    self.pickerView.userInteractionEnabled = _enabled;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[REBoolItem class]] && [keyPath isEqualToString:@"enabled"]) {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.enabled = newValue;
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!self.selected)
        [self setSelected:YES animated:NO];
    
    NSIndexPath *indexPath = [self indexPathForNextResponder];
    if (indexPath) {
        textField.returnKeyType = UIReturnKeyNext;
    } else {
        textField.returnKeyType = UIReturnKeyDefault;
    }
    [self updateActionBarNavigationControl];
    [self.parentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.rowIndex inSection:self.sectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self setSelected:NO animated:NO];
    [self.item deselectRowAnimated:NO];
    [self shouldUpdateItemValue];
    return YES;
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.item.options.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self.item.options objectAtIndex:component] count];
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *items = [self.item.options objectAtIndex:component];
    return [items objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self shouldUpdateItemValue];
    if (self.item.onChange)
        self.item.onChange(self.item);

    [pickerView reloadAllComponents];
    [self shouldUpdateItemValue];

}

@end
