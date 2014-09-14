//
//  NSString+RENumberFormat.m
//  REFormattedNumberFieldExample
//
//  Created by Roman Efimov on 9/13/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "NSString+RENumberFormat.h"

@implementation NSString (RENumberFormat)

- (NSString *)re_stringWithNumberFormat:(NSString *)format
{
    if (self.length == 0 || format.length == 0)
        return self;
    
    format = [format stringByAppendingString:@"X"];
    NSString *string = [self stringByAppendingString:@"0"];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\D" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSString *stripped = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:@""];
    
    NSMutableArray *patterns = [[NSMutableArray alloc] init];
    NSMutableArray *separators = [[NSMutableArray alloc] init];
    [patterns addObject:@0];
    
    NSInteger maxLength = 0;
    for (NSInteger i = 0; i < [format length]; i++) {
        NSString *character = [format substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"X"]) {
            maxLength++;
            NSNumber *number = [patterns objectAtIndex:patterns.count - 1];
            number = @(number.integerValue + 1);
            [patterns replaceObjectAtIndex:patterns.count - 1 withObject:number];
        } else {
            [patterns addObject:@0];
            [separators addObject:character];
        }
    }
    
    if (stripped.length > maxLength)
        stripped = [stripped substringToIndex:maxLength];
    
    NSString *match = @"";
    NSString *replace = @"";
    
    NSMutableArray *expressions = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < patterns.count; i++) {
        NSString *currentMatch = [match stringByAppendingString:@"(\\d+)"];
        match = [match stringByAppendingString:[NSString stringWithFormat:@"(\\d{%ld})", (long)((NSNumber *)[patterns objectAtIndex:i]).integerValue]];
        
        NSString *template;
        if (i == 0) {
            template = [NSString stringWithFormat:@"$%li", (long)i+1];
        } else {
            unichar separatorCharacter = [[separators objectAtIndex:i-1] characterAtIndex:0];
            template = [NSString stringWithFormat:@"\\%C$%li", separatorCharacter, (long)i+1];

        }
        replace = [replace stringByAppendingString:template];
        [expressions addObject:@{@"match": currentMatch, @"replace": replace}];
    }
    
    NSString *result = [stripped copy];
    
    for (NSDictionary *exp in expressions) {
        NSString *match = [exp objectForKey:@"match"];
        NSString *replace = [exp objectForKey:@"replace"];
        NSString *modifiedString = [stripped stringByReplacingOccurrencesOfString:match
                                                                       withString:replace
                                                                          options:NSRegularExpressionSearch
                                                                            range:NSMakeRange(0, stripped.length)];
        
        if (![modifiedString isEqualToString:stripped])
            result = modifiedString;
    }
    return [result substringWithRange:NSMakeRange(0, result.length - 1)];
}

@end
