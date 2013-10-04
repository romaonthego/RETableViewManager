//
// RETableViewSegmentedCell.m
// RETableViewManager
//
// Copyright (c) 2013 Dmitry Shmidt (https://github.com/shmidt)
//                    Roman Efimov (https://github.com/romaonthego)
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

#import "RETableViewSegmentedCell.h"
#import "RETableViewManager.h"
#import "NSString+RETableViewManagerAdditions.h"

@interface RETableViewSegmentedCell ()

@property (strong, readwrite, nonatomic) UISegmentedControl *segmentedControl;

@end

@implementation RETableViewSegmentedCell

#pragma mark -
#pragma mark Lifecycle

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:self.item.segmentedControlTitles];
    self.segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.segmentedControl addTarget:self action:@selector(segmentValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.segmentedControl];
    
    if (!REUIKitIsFlatMode()) {
        self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    }
}

- (void)cellWillAppear
{
    self.textLabel.text = self.item.title;
    [self.contentView removeConstraints:self.contentView.constraints];
    [self.segmentedControl removeAllSegments];
    CGFloat margin = (REUIKitIsFlatMode() && self.section.style.contentViewMargin <= 0) ? 15.0 : 10.0;
    NSDictionary *metrics = @{@"margin": @(margin)};
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentedControl
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0
                                                                  constant:0]];
    if (self.item.title.length > 0) {
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_segmentedControl(>=140)]-margin-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_segmentedControl)]];
    } else {
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_segmentedControl]-margin-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_segmentedControl)]];
    }
    
    if (self.item.segmentedControlTitles.count > 0) {
        [self.item.segmentedControlTitles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
            [self.segmentedControl insertSegmentWithTitle:title atIndex:idx animated:NO];
        }];
    } else if (self.item.segmentedControlImages.count > 0) {
        [self.item.segmentedControlImages enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
            [self.segmentedControl insertSegmentWithImage:image atIndex:idx animated:NO];
        }];
    }
    self.segmentedControl.tintColor = self.item.tintColor;
    self.segmentedControl.selectedSegmentIndex = self.item.value;
    [self.segmentedControl setNeedsDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width - self.segmentedControl.frame.size.width - self.section.style.contentViewMargin - 10.0, self.textLabel.frame.size.height);
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
