//
// RETableViewNumberCell.m
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

#import "RETableViewNumberCell.h"
#import "RETableViewManager.h"

@interface RETableViewNumberCell ()

@property (strong, readwrite, nonatomic) REFormattedNumberField *textFieldNumber;

@property (assign, readwrite, nonatomic) BOOL enabled;

@end

@implementation RETableViewNumberCell

@synthesize item = _item;

+ (BOOL)canFocusWithItem:(RETableViewItem *)item
{
    return YES;
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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    self.textFieldNumber = [[REFormattedNumberField alloc] initWithFrame:CGRectZero];
    self.textFieldNumber.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textFieldNumber.inputAccessoryView = self.actionBar;
    self.textFieldNumber.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textFieldNumber.delegate = self;
    [self.textFieldNumber addTarget:self action:@selector(textFieldNumberDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:self.textFieldNumber];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    self.textLabel.text = self.item.title.length == 0 ? @" " : self.item.title;
    self.textFieldNumber.text = [self.item.value re_stringWithNumberFormat:self.item.format];
    self.textFieldNumber.placeholder = self.item.placeholder;
    self.textFieldNumber.format = self.item.format;
    self.textFieldNumber.font = [UIFont systemFontOfSize:17];
    self.textFieldNumber.keyboardAppearance = self.item.keyboardAppearance;
    self.textFieldNumber.keyboardType = UIKeyboardTypeNumberPad;
    
    self.enabled = self.item.enabled;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if ([self.tableViewManager.delegate respondsToSelector:@selector(tableView:willLayoutCellSubviews:forRowAtIndexPath:)])
        [self.tableViewManager.delegate tableView:self.tableViewManager.tableView willLayoutCellSubviews:self forRowAtIndexPath:[self.tableViewManager.tableView indexPathForCell:self]];
}

#pragma mark -
#pragma mark Handle state

- (void)setItem:(RENumberItem *)item
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
    self.textFieldNumber.enabled = _enabled;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[RENumberItem class]] && [keyPath isEqualToString:@"enabled"]) {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.enabled = newValue;
    }
}

#pragma mark -
#pragma mark Handle events

- (void)textFieldNumberDidChange:(REFormattedNumberField *)textField
{
    self.item.value = textField.unformattedText;
    if (self.item.onChange)
        self.item.onChange(self.item);
}
- (void)textFieldNumberDidEndEditing:(UITextField *)textField{
    if (self.item.onEndEditing)
        self.item.onEndEditing(self.item);
}

@end
