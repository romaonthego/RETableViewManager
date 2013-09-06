//
// REValidation.m
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

#import "REValidation.h"

@interface REValidation ()

@property (strong, readwrite, nonatomic) NSMutableDictionary *registeredValidators;
@property (strong, readwrite, nonatomic) NSMutableDictionary *errorMessages;

@end

@implementation REValidation

+ (instancetype)sharedObject
{
    static REValidation *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[REValidation alloc] init];
    });

    return _sharedClient;
}

+ (void)registerValidator:(Class)validatorClass
{
    [REValidation sharedObject].registeredValidators[[validatorClass name]] = NSStringFromClass(validatorClass);
}

+ (void)registerDefaultValidators
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [REValidation registerValidator:[REPresenceValidator class]];
        [REValidation registerValidator:[RELengthValidator class]];
        [REValidation registerValidator:[REEmailValidator class]];
        [REValidation registerValidator:[REURLValidator class]];
    });
}

+ (void)registerDefaultErrorMessages
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *messages = @{
                                   @"com.REValidation.presence": @"%@ can't be blank.",
                                   @"com.REValidation.minimumLength": @"%@ is too short (minimum is %i characters).",
                                   @"com.REValidation.maximumLength": @"%@ is too long (maximum is %i characters).",
                                   @"com.REValidation.email": @"%@ is not a valid email.",
                                   @"com.REValidation.url": @"%@ is not a valid url."
                                   };
        [REValidation sharedObject].errorMessages = [NSMutableDictionary dictionaryWithDictionary:messages];
    });
}

+ (NSString *)errorMessageForDomain:(NSString *)domain
{
    return NSLocalizedString([REValidation sharedObject].errorMessages[domain], [REValidation sharedObject].errorMessages[domain]);
}

+ (void)setErrorMessage:(NSString *)message forDomain:(NSString *)domain
{
    [REValidation sharedObject].errorMessages[domain] = message;
}

+ (void)setErrorMessages:(NSDictionary *)messages
{
    [REValidation sharedObject].errorMessages = [NSMutableDictionary dictionaryWithDictionary:messages];
}

+ (NSError *)validateObject:(NSObject *)object name:(NSString *)name validatorString:(NSString *)string
{
    NSString *validatorStringName = [string componentsSeparatedByString:@"("][0];
    for (NSString *validatorName in [REValidation sharedObject].registeredValidators) {
        if ([validatorName isEqualToString:validatorStringName]) {
            Class validator = NSClassFromString([REValidation sharedObject].registeredValidators[validatorName]);
            return [[validator class] validateObject:object variableName:name parameters:[validator parseParameterString:string]];
        }
    }
    return nil;
}

+ (NSError *)validateObject:(NSObject *)object name:(NSString *)name validator:(REValidator *)validator
{
    return [[validator class] validateObject:object variableName:name parameters:validator.parameters];
}

+ (NSArray *)validateObject:(NSObject *)object name:(NSString *)name validators:(NSArray *)validators
{
    NSMutableArray *errors = [NSMutableArray array];

    for (id validator in validators) {
        NSError *error;
        if ([validator isKindOfClass:[NSString class]]) {
            error = [self validateObject:object name:name validatorString:(NSString *)validator];
        } else {
            REValidator *v = (REValidator *)validator;
            if (v.inlineValidation) {
                error = [[v class] validateObject:object variableName:name validation:v.inlineValidation];
            } else {
                error = [self validateObject:object name:name validator:validator];
            }
        }
        if (error)
            [errors addObject:error];
    }

    return errors;
}


- (id)init
{
    self = [super init];
    if (!self)
        return nil;

    self.registeredValidators = [[NSMutableDictionary alloc] init];

    return self;
}

@end
