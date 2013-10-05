//
//  RETableViewInlinePickerCell.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 10/5/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewInlinePickerCell.h"
#import "REPickerItem.h"

@interface RETableViewInlinePickerCell ()

@property (strong, readwrite, nonatomic) UIPickerView *pickerView;

@end

@implementation RETableViewInlinePickerCell

+ (CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 216.0f;
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
