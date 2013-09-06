//
// REValidation.h
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

#import <Foundation/Foundation.h>
#import "REValidator.h"
#import "NSError+REValidation.h"
#import "REPresenceValidator.h"
#import "RELengthValidator.h"
#import "REEmailValidator.h"
#import "REURLValidator.h"

@interface REValidation : NSObject

///-----------------------------
/// @name Registering Validators
///-----------------------------

+ (void)registerDefaultValidators;
+ (void)registerDefaultErrorMessages;
+ (void)registerValidator:(Class)validatorClass;

///-----------------------------
/// @name Validating Objects
///-----------------------------

+ (NSError *)validateObject:(NSObject *)object name:(NSString *)name validatorString:(NSString *)string;
+ (NSError *)validateObject:(NSObject *)object name:(NSString *)name validator:(REValidator *)validator;
+ (NSArray *)validateObject:(NSObject *)object name:(NSString *)name validators:(NSArray *)validators;

///-----------------------------
/// @name Handling Error Messages
///-----------------------------

+ (NSString *)errorMessageForDomain:(NSString *)domain;
+ (void)setErrorMessage:(NSString *)message forDomain:(NSString *)domain;
+ (void)setErrorMessages:(NSDictionary *)messages;

@end
