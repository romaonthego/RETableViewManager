//
//  ListImageCell.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/2/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ListImageCell.h"

@implementation ListImageCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 306;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    _pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 0, 306, 306)];
    _pictureView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:_pictureView];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    [_pictureView setImage:[UIImage imageNamed:self.item.imageName]];
}

- (void)cellDidDisappear
{
    
}

@end
