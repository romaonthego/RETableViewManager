//
//  MultilineTextCell.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 9/11/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "MultilineTextCell.h"
#import "RETableViewManager.h"

static const CGFloat kHorizontalMargin = 10.0;
static const CGFloat kVerticalMargin = 10.0;

@interface MultilineTextCell ()

@property (strong, readwrite, nonatomic) UILabel *multilineLabel;

@end

@implementation MultilineTextCell

+ (CGFloat)heightWithItem:(MultilineTextItem *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    CGFloat width = CGRectGetWidth(tableViewManager.tableView.bounds) - 2.0 * kHorizontalMargin;
    return [item.title sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(width, INFINITY)].height + 2.0 * kVerticalMargin;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.multilineLabel = [[UILabel alloc] init];
    self.multilineLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.multilineLabel.font = [UIFont systemFontOfSize:17];
    self.multilineLabel.numberOfLines = 0;
    [self.contentView addSubview:self.multilineLabel];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    self.textLabel.text = @"";
    self.multilineLabel.text = self.item.title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), [MultilineTextCell heightWithItem:self.item tableViewManager:self.tableViewManager]);
    frame = CGRectInset(frame, kHorizontalMargin, kVerticalMargin);
    
    self.multilineLabel.frame = frame;
}

@end
