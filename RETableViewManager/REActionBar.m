//
// REActionBar.m
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

#import "REActionBar.h"
#import "RETableViewManager.h"
#import "UIImage+REBundle.h"

@interface REActionBar ()

@property (strong, readwrite, nonatomic) UISegmentedControl *navigationControl;

@end

@implementation REActionBar

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if (!self)
        return nil;
    
    [self sizeToFit];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(handleActionBarDone:)];
    
    self.navigationControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Previous", @""), NSLocalizedString(@"Next", @""), nil]];
    self.navigationControl.momentary = YES;
    [self.navigationControl addTarget:self action:@selector(handleActionBarPreviousNext:) forControlEvents:UIControlEventValueChanged];
    
    [self.navigationControl setImage:[UIImage re_bundledImageNamed:@"UIButtonBarArrowLeft" ofType:@"png"] forSegmentAtIndex:0];
    [self.navigationControl setImage:[UIImage re_bundledImageNamed:@"UIButtonBarArrowRight" ofType:@"png"] forSegmentAtIndex:1];
    [self.navigationControl setBackgroundImage:[UIImage re_bundledImageNamed:@"Transparent" ofType:@"png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    [self.navigationControl setDividerImage:[[UIImage alloc] init]
                        forLeftSegmentState:UIControlStateNormal
                          rightSegmentState:UIControlStateNormal
                                 barMetrics:UIBarMetricsDefault];

    [self.navigationControl setWidth:40.0f forSegmentAtIndex:0];
    [self.navigationControl setWidth:40.0f forSegmentAtIndex:1];
    [self.navigationControl setContentOffset:CGSizeMake(-4, 0) forSegmentAtIndex:0];
    
    UIBarButtonItem *prevNextWrapper = [[UIBarButtonItem alloc] initWithCustomView:self.navigationControl];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self setItems:[NSArray arrayWithObjects:prevNextWrapper, flexible, doneButton, nil]];
    self.actionBarDelegate = delegate;
    
    return self;
}

- (void)handleActionBarPreviousNext:(UISegmentedControl *)segmentedControl
{
    if ([self.actionBarDelegate respondsToSelector:@selector(actionBar:navigationControlValueChanged:)])
        [self.actionBarDelegate actionBar:self navigationControlValueChanged:segmentedControl];
}

- (void)handleActionBarDone:(UIBarButtonItem *)doneButtonItem
{
    if ([self.actionBarDelegate respondsToSelector:@selector(actionBar:doneButtonPressed:)])
        [self.actionBarDelegate actionBar:self doneButtonPressed:doneButtonItem];
}

@end
