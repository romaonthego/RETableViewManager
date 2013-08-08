//
// RETableViewBoolCell.m
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

#import "RETableViewBoolCell.h"
#import "RETableViewManager.h"

@implementation RETableViewBoolCell

#pragma mark -
#pragma mark Lifecycle

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _switchView = [[UISwitch alloc] init];
    _switchView.translatesAutoresizingMaskIntoConstraints = NO;
    [_switchView addTarget:self action:@selector(switchValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_switchView];
}

- (void)cellWillAppear
{
    [self.contentView removeConstraints:self.contentView.constraints];
    CGFloat margin = (REDeviceIsUIKit7() && self.section.style.contentViewMargin <= 0) ? 15.0 : 10.0;
    NSDictionary *metrics = @{@"margin": @(margin)};
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_switchView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0
                                                                  constant:0]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_switchView]-margin-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_switchView)]];
    
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.text = self.item.title;
    _switchView.on = self.item.value;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if ([self.tableViewManager.delegate respondsToSelector:@selector(tableView:willLayoutCellSubviews:forRowAtIndexPath:)])
        [self.tableViewManager.delegate tableView:self.tableViewManager.tableView willLayoutCellSubviews:self forRowAtIndexPath:[(UITableView *)self.superview indexPathForCell:self]];
}

#pragma mark -
#pragma mark Handle events

- (void)switchValueDidChange:(UISwitch *)switchView
{
    self.item.value = switchView.isOn;
    if (self.item.switchValueChangeHandler)
        self.item.switchValueChangeHandler(self.item);
}

@end
