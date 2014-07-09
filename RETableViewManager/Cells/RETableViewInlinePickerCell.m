//
//  RETableViewInlinePickerCell.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 10/5/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewInlinePickerCell.h"
#import "RETableViewManager.h"
#import "REPickerItem.h"

@interface RETableViewInlinePickerCell ()

@property (strong, readwrite, nonatomic) UIPickerView *pickerView;

@property (assign, readwrite, nonatomic) BOOL enabled;

@end

@implementation RETableViewInlinePickerCell

@synthesize item = _item;

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 216.0f;
}

- (void)dealloc {
    if (_item != nil) {
        [_item removeObserver:self forKeyPath:@"enabled"];
    }
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.contentView addSubview:self.pickerView];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.item.pickerItem.options enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([self.item.pickerItem.options objectAtIndex:idx] && [self.item.pickerItem.value objectAtIndex:idx] > 0)
            [self.pickerView selectRow:[[self.item.pickerItem.options objectAtIndex:idx] indexOfObject:[self.item.pickerItem.value objectAtIndex:idx]] inComponent:idx animated:NO];
    }];
    [self.pickerView reloadAllComponents];
    
    self.enabled = self.item.enabled;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.pickerView.frame = self.bounds;
    
    if ([self.tableViewManager.delegate respondsToSelector:@selector(tableView:willLayoutCellSubviews:forRowAtIndexPath:)])
        [self.tableViewManager.delegate tableView:self.tableViewManager.tableView willLayoutCellSubviews:self forRowAtIndexPath:[self.tableViewManager.tableView indexPathForCell:self]];
}

#pragma mark -
#pragma mark Handle state

- (void)setItem:(REInlinePickerItem *)item
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
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.item.pickerItem.options.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self.item.pickerItem.options objectAtIndex:component] count];
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *items = [self.item.pickerItem.options objectAtIndex:component];
    return [items objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self shouldUpdateItemValue];
    if (self.item.pickerItem.onChange)
        self.item.pickerItem.onChange(self.item.pickerItem);

    [pickerView reloadAllComponents];
    [self shouldUpdateItemValue];
}

- (void)shouldUpdateItemValue
{
    NSMutableArray *value = [NSMutableArray array];
    [self.item.pickerItem.options enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *options = [self.item.pickerItem.options objectAtIndex:idx];
        NSString *valueText = [options objectAtIndex:[self.pickerView selectedRowInComponent:idx]];
        [value addObject:valueText];
    }];
    self.item.pickerItem.value = [value copy];
    [self.item.pickerItem reloadRowWithAnimation:UITableViewRowAnimationNone];
}

@end
