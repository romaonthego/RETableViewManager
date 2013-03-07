//
//  RECreditCardItem.m
//  Meungry
//
//  Created by Roman Efimov on 3/7/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RECreditCardItem.h"

@implementation RECreditCardItem

+ (id)item
{
    return [[self alloc] init];
}

+ (id)itemWithNumber:(NSString *)number expirationDate:(NSString *)expirationDate cvv:(NSString *)cvv
{
    return [[self alloc] initWithNumber:number expirationDate:expirationDate cvv:cvv];
}

- (id)initWithNumber:(NSString *)number expirationDate:(NSString *)expirationDate cvv:(NSString *)cvv
{
    self = [super init];
    if (!self)
        return nil;
    
    self.number = number;
    self.expirationDate = expirationDate;
    self.cvv = cvv;
    
    return self;
}

- (BOOL)canFocus
{
    return YES;
}

@end
