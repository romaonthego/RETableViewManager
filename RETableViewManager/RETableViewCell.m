//
// RETableViewCell.m
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

#import "RETableViewCell.h"
#import "RETableViewManager.h"

@implementation RETableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableViewManager:(RETableViewManager *)tableViewManager
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tableViewManager = tableViewManager;
        if ([self hasCustomBackgroundImage]) {
            self.backgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
            self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            _backgroundImageView = [[UIImageView alloc] init];
            [self.backgroundView addSubview:_backgroundImageView];
        }
    }
    return self;
}

- (BOOL)hasCustomBackgroundImage
{
    return [self.tableViewManager.style backgroundImageForCellType:RETableViewCellFirst] || [self.tableViewManager.style backgroundImageForCellType:RETableViewCellMiddle] || [self.tableViewManager.style backgroundImageForCellType:RETableViewCellLast] || [self.tableViewManager.style backgroundImageForCellType:RETableViewCellSingle];
}

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return tableViewManager.style.cellHeight;
}

- (void)prepare
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([self hasCustomBackgroundImage]) {
        if (self.row == 0 && self.section.items.count == 1) {
            _backgroundImageView.image = [self.tableViewManager.style backgroundImageForCellType:RETableViewCellSingle];
        }
        
        if (self.row == 0 && self.section.items.count > 1) {
            _backgroundImageView.image = [self.tableViewManager.style backgroundImageForCellType:RETableViewCellFirst];
        }
        
        if (self.row > 0 && self.row < self.section.items.count - 1 && self.section.items.count > 2) {
            _backgroundImageView.image = [self.tableViewManager.style backgroundImageForCellType:RETableViewCellMiddle];
        }
        
        if (self.row == self.section.items.count - 1 && self.section.items.count > 1) {
            _backgroundImageView.image = [self.tableViewManager.style backgroundImageForCellType:RETableViewCellLast];
            
        }
        _backgroundImageView.frame = CGRectMake(0, 0, _backgroundImageView.image.size.width, _backgroundImageView.image.size.height);
    }
}

@end
