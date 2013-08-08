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

@implementation REActionBar

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if (!self)
        return nil;
    
    [self sizeToFit];
    
    if (!REDeviceIsUIKit7()) {
        self.translucent = YES;
        self.barStyle = UIBarStyleBlackTranslucent;
    }
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"") style:UIBarButtonItemStyleDone target:self action:@selector(handleActionBarDone:)];
    
    _navigationControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Previous", @""), NSLocalizedString(@"Next", @""), nil]];
    _navigationControl.momentary = YES;
    _navigationControl.segmentedControlStyle = UISegmentedControlStyleBar;
    _navigationControl.tintColor = self.tintColor;
    [_navigationControl addTarget:self action:@selector(handleActionBarPreviousNext:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *prevNextWrapper = [[UIBarButtonItem alloc] initWithCustomView:_navigationControl];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self setItems:[NSArray arrayWithObjects:prevNextWrapper, flexible, doneButton, nil]];
    self.actionBarDelegate = delegate;
    
    return self;
}

- (void)handleActionBarPreviousNext:(UISegmentedControl *)segmentedControl
{
    if ([_actionBarDelegate respondsToSelector:@selector(actionBar:navigationControlValueChanged:)])
        [_actionBarDelegate actionBar:self navigationControlValueChanged:segmentedControl];
}

- (void)handleActionBarDone:(UIBarButtonItem *)doneButtonItem
{
    if ([_actionBarDelegate respondsToSelector:@selector(actionBar:doneButtonPressed:)])
        [_actionBarDelegate actionBar:self doneButtonPressed:doneButtonItem];
}

@end
