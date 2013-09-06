//
// REValidator.m
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

#import "REValidator.h"

@interface REValidator ()

@property (strong, readwrite, nonatomic) NSDictionary *parameters;

@end

@implementation REValidator

+ (instancetype)validator
{
    return [[self alloc] init];
}

+ (instancetype)validatorWithParameters:(NSDictionary *)parameters
{
    REValidator *validator = [[self alloc] init];
    validator.parameters = parameters;
    return validator;
}

+ (instancetype)validatorWithInlineValidation:(NSError *(^)(id object, NSString *name))validation
{
    REValidator *validator = [[self alloc] init];
    validator.inlineValidation = validation;
    return validator;
}

+ (NSString *)name
{
    return @"";
}

+ (NSError *)validateObject:(NSObject *)object variableName:(NSString *)name parameters:(NSDictionary *)parameters
{
    return nil;
}

+ (NSError *)validateObject:(NSObject *)object variableName:(NSString *)name validation:(NSError *(^)(id object, NSString *name))validation
{
    if (validation)
        return validation(object, name);
    return nil;
}

+ (NSDictionary *)parseParameterString:(NSString *)string
{
    return nil;
}

@end
