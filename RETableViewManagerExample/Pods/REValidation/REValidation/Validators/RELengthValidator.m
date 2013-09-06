//
// RELengthValidator.m
// REValidation
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "RELengthValidator.h"
#import "NSError+REValidation.h"

@implementation RELengthValidator

+ (NSString *)name
{
    return @"length";
}

+ (NSDictionary *)parseParameterString:(NSString *)string
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\d+)" options:0 error:&error];
    NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    NSMutableArray *results = [NSMutableArray array];
    for (NSTextCheckingResult *matchResult in matches) {
        NSString *match = [string substringWithRange:[matchResult range]];
        [results addObject:match];
    }
    if (results.count == 2) {
        return @{ @"min": results[0], @"max": results[1]};
    }
    
    return nil;
}

+ (NSError *)validateObject:(NSString *)object variableName:(NSString *)name parameters:(NSDictionary *)parameters
{
    NSUInteger minimumValue = [parameters[@"min"] integerValue];
    NSUInteger maximumValue = [parameters[@"max"] integerValue];
    
    if (object.length < minimumValue && minimumValue > 0)
        return [NSError re_validationErrorForDomain:@"com.REValidation.minimumLength", name, minimumValue];
    
    if (object.length > maximumValue && maximumValue > 0)
        return [NSError re_validationErrorForDomain:@"com.REValidation.maximumLength", name, maximumValue];

    return nil;
}

@end
