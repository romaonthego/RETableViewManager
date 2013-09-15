//
// RETableViewCellStyle.m
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

#import "RETableViewCellStyle.h"
#import "RETableViewManager.h"

@implementation RETableViewCellStyle

- (id)init
{
    self = [super init];
    if (!self)
        return nil;
    
    self.backgroundImages = [[NSMutableDictionary alloc] init];
    self.selectedBackgroundImages = [[NSMutableDictionary alloc] init];
    self.cellHeight = 44.0;
    self.defaultCellSelectionStyle = UITableViewCellSelectionStyleBlue;
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    RETableViewCellStyle *style = [[self class] allocWithZone:zone];
    if (style) {
        style.backgroundImages = [NSMutableDictionary dictionaryWithDictionary:[self.backgroundImages copyWithZone:zone]];
        style.selectedBackgroundImages = [NSMutableDictionary dictionaryWithDictionary:[self.selectedBackgroundImages copyWithZone:zone]];
        style.cellHeight = self.cellHeight;
        style.defaultCellSelectionStyle = self.defaultCellSelectionStyle;
        style.backgroundImageMargin = self.backgroundImageMargin;
        style.contentViewMargin = self.contentViewMargin;
    }
    return style;
}

- (BOOL)hasCustomBackgroundImage
{
    return [self backgroundImageForCellType:RETableViewCellTypeAny] || [self backgroundImageForCellType:RETableViewCellTypeFirst] || [self backgroundImageForCellType:RETableViewCellTypeMiddle] || [self backgroundImageForCellType:RETableViewCellTypeLast] || [self backgroundImageForCellType:RETableViewCellTypeSingle];
}

- (UIImage *)backgroundImageForCellType:(RETableViewCellType)cellType
{
    UIImage *image = [self.backgroundImages objectForKey:@(cellType)];
    if (!image && cellType != RETableViewCellTypeAny)
        image = [self.backgroundImages objectForKey:@(RETableViewCellTypeAny)];
    return image;
}

- (void)setBackgroundImage:(UIImage *)image forCellType:(RETableViewCellType)cellType
{
    if (image)
        [self.backgroundImages setObject:image forKey:@(cellType)];
}

- (BOOL)hasCustomSelectedBackgroundImage
{
    return [self selectedBackgroundImageForCellType:RETableViewCellTypeAny] ||[self selectedBackgroundImageForCellType:RETableViewCellTypeFirst] || [self selectedBackgroundImageForCellType:RETableViewCellTypeMiddle] || [self selectedBackgroundImageForCellType:RETableViewCellTypeLast] || [self selectedBackgroundImageForCellType:RETableViewCellTypeSingle];
}

- (UIImage *)selectedBackgroundImageForCellType:(RETableViewCellType)cellType
{
    UIImage *image = [self.selectedBackgroundImages objectForKey:@(cellType)];
    if (!image && cellType != RETableViewCellTypeAny)
        image = [self.selectedBackgroundImages objectForKey:@(RETableViewCellTypeAny)];
    return image;
}

- (void)setSelectedBackgroundImage:(UIImage *)image forCellType:(RETableViewCellType)cellType
{
    if (image)
        [self.selectedBackgroundImages setObject:image forKey:@(cellType)];
}

@end
