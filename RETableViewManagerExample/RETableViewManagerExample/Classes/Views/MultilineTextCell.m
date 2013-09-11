//
//  MultilineTextCell.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 9/11/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "MultilineTextCell.h"

@interface MultilineTextCell ()

@property (strong, readwrite, nonatomic) UILabel *multilineLabel;

@end

@implementation MultilineTextCell

+ (CGFloat)heightWithItem:(MultilineTextItem *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return [item.title sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(280.0, INFINITY)].height + 20.0;
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
    self.multilineLabel.frame = CGRectMake((self.contentView.frame.size.width - 280.0) / 2.0, 10.0, 280.0, [MultilineTextCell heightWithItem:self.item tableViewManager:self.tableViewManager] - 20.0);
}

@end
