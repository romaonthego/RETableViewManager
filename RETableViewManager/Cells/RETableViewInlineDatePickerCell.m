//
//  RETableViewInlineDatePickerCell.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 10/4/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewInlineDatePickerCell.h"
#import "RETableViewManager.h"
#import "REDateTimeItem.h"

@interface RETableViewInlineDatePickerCell ()

@property (strong, readwrite, nonatomic) UIDatePicker *datePicker;

@property (assign, readwrite, nonatomic) BOOL enabled;

@end

@implementation RETableViewInlineDatePickerCell

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
    self.datePicker = [[UIDatePicker alloc] init];
    [self.contentView addSubview:self.datePicker];
    [self.datePicker addTarget:self action:@selector(datePickerValueDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.datePicker.date = self.item.dateTimeItem.value ? self.item.dateTimeItem.value : [NSDate date];
    self.datePicker.datePickerMode = self.item.dateTimeItem.datePickerMode;
    self.datePicker.locale = self.item.dateTimeItem.locale;
    self.datePicker.calendar = self.item.dateTimeItem.calendar;
    self.datePicker.timeZone = self.item.dateTimeItem.timeZone;
    self.datePicker.minimumDate = self.item.dateTimeItem.minimumDate;
    self.datePicker.maximumDate = self.item.dateTimeItem.maximumDate;
    self.datePicker.minuteInterval = self.item.dateTimeItem.minuteInterval;
    
    self.enabled = self.item.enabled;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.datePicker.frame = self.bounds;
    
    if ([self.tableViewManager.delegate respondsToSelector:@selector(tableView:willLayoutCellSubviews:forRowAtIndexPath:)])
        [self.tableViewManager.delegate tableView:self.tableViewManager.tableView willLayoutCellSubviews:self forRowAtIndexPath:[self.tableViewManager.tableView indexPathForCell:self]];
}

#pragma mark -
#pragma mark Handle state

- (void)setItem:(REInlineDatePickerItem *)item
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
    self.datePicker.enabled = _enabled;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[REBoolItem class]] && [keyPath isEqualToString:@"enabled"]) {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.enabled = newValue;
    }
}

#pragma mark -
#pragma mark Date picker value

- (void)datePickerValueDidChange:(UIDatePicker *)datePicker
{
    self.item.dateTimeItem.value = self.datePicker.date;
    if (self.item.dateTimeItem) {
        self.item.dateTimeItem.value = self.datePicker.date;
        if (self.item.dateTimeItem.onChange)
            self.item.dateTimeItem.onChange(self.item.dateTimeItem);
        [self.item.dateTimeItem reloadRowWithAnimation:UITableViewRowAnimationNone];
    }
}

@end
