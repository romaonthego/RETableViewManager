//
// RETableViewOptionCell.m
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

#import "RETableViewOptionCell.h"
#import "RETableViewManager.h"

@implementation RETableViewOptionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = self.tableViewManager.style.defaultCellSelectionStyle;
    
    _valueLabel = [[UILabel alloc] initWithFrame:CGRectNull];
    _valueLabel.font = [UIFont systemFontOfSize:17];
    _valueLabel.backgroundColor = [UIColor clearColor];
    _valueLabel.textColor = self.detailTextLabel.textColor;
    _valueLabel.highlightedTextColor = [UIColor whiteColor];
    _valueLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_valueLabel];
}

- (void)cellWillAppear
{
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.text = self.item.title;
    self.detailTextLabel.text = @"";
    self.valueLabel.text = self.item.detailLabelText;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellOffset = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 10 : 10;
    CGFloat fieldOffset = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 10 : 10;
    CGFloat width = 0;
    CGRect frame = CGRectMake(0, self.tableViewManager.style.textFieldPositionOffset.height - 1, 0, self.contentView.frame.size.height - self.tableViewManager.style.textFieldPositionOffset.height);
    if (self.item.title && ![self.item.title isEqualToString:@""]) {
        for (RETableViewItem *item in self.section.items) {
            if ([item isMemberOfClass:[RETextItem class]] || [item isMemberOfClass:[REDateTimeItem class]]) {
                CGSize size = [item.title sizeWithFont:self.textLabel.font];
                width = MAX(width, size.width);
            }
        }
        frame.origin.x = width + cellOffset + fieldOffset + self.tableViewManager.style.textFieldPositionOffset.width;
    } else {
        frame.origin.x = cellOffset + self.tableViewManager.style.textFieldPositionOffset.width;
    }
    frame.size.width = self.contentView.frame.size.width - frame.origin.x - cellOffset;
    _valueLabel.frame = frame;
    
    if ([self.tableViewManager.delegate respondsToSelector:@selector(tableView:willLayoutCellSubviews:)])
        [self.tableViewManager.delegate tableView:self.tableViewManager.tableView willLayoutCellSubviews:self];
}

@end
