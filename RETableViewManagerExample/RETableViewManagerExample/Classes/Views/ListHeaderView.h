//
//  ListHeaderView.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 4/2/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListHeaderView : UIView

@property (strong, readonly, nonatomic) UIImageView *userpicImageView;
@property (strong, readonly, nonatomic) UILabel *usernameLabel;

+ (ListHeaderView *)headerViewWithImageNamed:(NSString *)imageName username:(NSString *)username;

@end
