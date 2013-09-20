//
//  NSString+RETableViewManagerAdditions.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 9/20/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RETableViewManagerAdditions)

- (CGSize)re_sizeWithFont:(UIFont *)font;
- (CGSize)re_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end
