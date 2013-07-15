//
//  ListHeaderView.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/2/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ListHeaderView.h"

@implementation ListHeaderView

+ (ListHeaderView *)headerViewWithImageNamed:(NSString *)imageNamed username:(NSString *)username
{
    ListHeaderView *view = [[ListHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [view.userpicImageView setImage:[UIImage imageNamed:imageNamed]];
    [view.usernameLabel setText:username];
    return view;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.alpha = 0.9;
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:backgroundView];
        
        _userpicImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 30, 30)];
        [self addSubview:_userpicImageView];
        
        _usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 3, 276, 35)];
        _usernameLabel.font = [UIFont boldSystemFontOfSize:14];
        _usernameLabel.textColor = [UIColor blackColor];
        _usernameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_usernameLabel];
    }
    return self;
}

@end
