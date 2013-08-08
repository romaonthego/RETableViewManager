//
// RETableViewFloatCell.m
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

#import "RETableViewFloatCell.h"
#import "RETableViewManager.h"

@implementation RETableViewFloatCell

#pragma mark -
#pragma mark Lifecycle

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _sliderView = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 100, 23.0)];
    [_sliderView addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.contentView addSubview:_sliderView];
}

- (void)cellWillAppear
{
    self.textLabel.text = self.item.title;
    self.textLabel.backgroundColor = [UIColor clearColor];
    _sliderView.value = self.item.value;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat cellOffset = 10.0;
    if (REDeviceIsUIKit7() && self.section.style.contentViewMargin <= 0)
        cellOffset += 5.0;
    
    _sliderView.frame = CGRectMake(self.contentView.frame.size.width - self.item.sliderWidth - cellOffset, (self.contentView.frame.size.height - _sliderView.frame.size.height) / 2.0, self.item.sliderWidth, 23.0);
    
    if ([self.tableViewManager.delegate respondsToSelector:@selector(tableView:willLayoutCellSubviews:forRowAtIndexPath:)])
        [self.tableViewManager.delegate tableView:self.tableViewManager.tableView willLayoutCellSubviews:self forRowAtIndexPath:[(UITableView *)self.superview indexPathForCell:self]];
}

#pragma mark -
#pragma mark Handle events

- (void)sliderValueDidChange:(UISlider *)slider
{
    self.item.value = slider.value;
    if (self.item.sliderValueChangeHandler)
        self.item.sliderValueChangeHandler(self.item);
}

@end
