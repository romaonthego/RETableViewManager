//
//  ListImageCell.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/2/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ListImageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ListImageCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 320;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableViewManager:(RETableViewManager *)tableViewManager
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier tableViewManager:tableViewManager];
    if (self) {
        _pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 0, 306, 306)];
        [self addSubview:_pictureView];
    }
    return self;
}

- (void)prepare
{
    [super prepare];
    [_pictureView setImageWithURL:self.item.imageURL];
}

@end
