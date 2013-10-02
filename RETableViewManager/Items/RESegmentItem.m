//
// RESegmentItem.m
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

#import "RESegmentItem.h"

@implementation RESegmentItem

+ (instancetype)itemWithTitles:(NSArray *)titles value:(int)value
{
    return [[self alloc] initWithTitles:titles value:value];
}

+ (instancetype)itemWithTitles:(NSArray *)titles value:(int)value switchValueChangeHandler:(void(^)(RESegmentItem *item))switchValueChangeHandler
{
    return [[self alloc] initWithTitles:titles value:value switchValueChangeHandler:switchValueChangeHandler];
}

- (id)initWithTitles:(NSArray *)titles value:(int)value
{
    return [self initWithTitles:titles value:value switchValueChangeHandler:nil];
}

- (id)initWithTitles:(NSArray *)titles value:(int)value switchValueChangeHandler:(void(^)(RESegmentItem *item))switchValueChangeHandler
{
    self = [super init];
    if (!self)
        return nil;
    
    self.titles = titles;
    self.value = value;
    self.switchValueChangeHandler = switchValueChangeHandler;
    
    return self;
}


+ (instancetype)itemWithImages:(NSArray *)images value:(int)value
{
    return [[self alloc] initWithImages:images value:value];
}

+ (instancetype)itemWithImages:(NSArray *)images value:(int)value switchValueChangeHandler:(void(^)(RESegmentItem *item))switchValueChangeHandler
{
    return [[self alloc] initWithImages:images value:value switchValueChangeHandler:switchValueChangeHandler];
}

- (id)initWithImages:(NSArray *)images value:(int)value
{
    return [self initWithImages:images value:value switchValueChangeHandler:nil];
}

- (id)initWithImages:(NSArray *)images value:(int)value switchValueChangeHandler:(void(^)(RESegmentItem *item))switchValueChangeHandler
{
    self = [super init];
    if (!self)
        return nil;
    
    self.images = images;
    self.value = value;
    self.switchValueChangeHandler = switchValueChangeHandler;
    
    return self;
}
@end

