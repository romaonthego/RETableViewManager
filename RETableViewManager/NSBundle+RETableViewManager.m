//
//  RETableViewManagerBundle.m
//  Pods
//
//  Created by Kel Bucey on 3/3/16.
//
//

#import "NSBundle+RETableViewManager.h"
#import "RETableViewManager.h"

@implementation NSBundle (RETableViewManager)

+ (instancetype)RETableViewManagerBundle {
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *containingBundle = [NSBundle bundleForClass:[RETableViewManager class]];
        NSURL *bundleURL = [containingBundle URLForResource:@"RETableViewManager" withExtension:@"bundle"];
        if (bundleURL) {
            bundle = [NSBundle bundleWithURL:bundleURL];
        }
    });
    
    return bundle;
}

@end
