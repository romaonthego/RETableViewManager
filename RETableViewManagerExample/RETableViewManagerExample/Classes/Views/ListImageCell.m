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
    return 306;
}

- (void)cellDidLoad
{
    _pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 0, 306, 306)];
    [self addSubview:_pictureView];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    [_pictureView setImageWithURL:self.item.imageURL];
}

- (void)cellDidDisappear
{
    
}

@end
