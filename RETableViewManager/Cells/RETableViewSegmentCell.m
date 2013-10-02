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

#import "RETableViewSegmentCell.h"
#import "RETableViewManager.h"

@implementation RETableViewSegmentCell

#pragma mark -
#pragma mark Lifecycle

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _segmentView = [[UISegmentedControl alloc] initWithItems:self.item.titles];
    _segmentView.translatesAutoresizingMaskIntoConstraints = NO;
    [_segmentView addTarget:self action:@selector(segmentValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_segmentView];
}

- (void)cellWillAppear
{
    [self.contentView removeConstraints:self.contentView.constraints];
    CGFloat margin = (REDeviceIsUIKit7() && self.section.style.contentViewMargin <= 0) ? 15.0 : 10.0;
    NSDictionary *metrics = @{@"margin": @(margin)};
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_segmentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0
                                                                  constant:0]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_segmentView]-margin-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_segmentView)]];
    if (self.item.titles.count > 0) {
        int i = 0;
        for (NSString *title in self.item.titles) {
            [_segmentView insertSegmentWithTitle:title atIndex:i animated:NO];
            i++;
        }
    }else if (self.item.images.count > 0){
        int i = 0;
        for (UIImage *image in self.item.images) {
            [_segmentView insertSegmentWithImage:image atIndex:i animated:NO];
            i++;
        }
    }

    _segmentView.selectedSegmentIndex = self.item.value;
    [_segmentView setNeedsDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width - self.segmentView.frame.size.width - self.section.style.contentViewMargin - 10.0, self.textLabel.frame.size.height);
    self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    if ([self.tableViewManager.delegate respondsToSelector:@selector(tableView:willLayoutCellSubviews:forRowAtIndexPath:)])
        [self.tableViewManager.delegate tableView:self.tableViewManager.tableView willLayoutCellSubviews:self forRowAtIndexPath:[(UITableView *)self.superview indexPathForCell:self]];
}

#pragma mark -
#pragma mark Handle events

- (void)segmentValueDidChange:(UISegmentedControl *)segmentedControlView
{
    self.item.value = segmentedControlView.selectedSegmentIndex;
    if (self.item.switchValueChangeHandler)
        self.item.switchValueChangeHandler(self.item);
}

@end
