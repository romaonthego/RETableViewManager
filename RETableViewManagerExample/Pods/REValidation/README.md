# REValidation

Simple Objective-C object validation.

Currently available default validators:

> * Presence validator
* String length validator
* Email validator

## Requirements
* Xcode 4.5 or higher
* Apple LLVM compiler
* iOS 5.0 or higher / Mac OS X 10.7 or higher
* ARC

## Installation

### CocoaPods

The recommended approach for installating `REValidation` is via the [CocoaPods](http://cocoapods.org/) package manager, as it provides flexible dependency management and dead simple installation.
For best results, it is recommended that you install via CocoaPods >= **0.15.2** using Git >= **1.8.0** installed via Homebrew.

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```

Change to the directory of your Xcode project:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
```

Edit your Podfile and add REValidation:

``` bash
pod 'REValidation', '~> 0.1.4'
```

Install into your Xcode project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file)

``` bash
$ open MyProject.xcworkspace
```

Please note that if your installation fails, it may be because you are installing with a version of Git lower than CocoaPods is expecting. Please ensure that you are running Git >= **1.8.0** by executing `git --version`. You can get a full picture of the installation details by executing `pod install --verbose`.

### Manual Install

All you need to do is drop `REValidation` files into your project, and add `#include "REValidation.h"` to the top of classes that will use it.

## Example Usage

``` objective-c
[REValidation registerDefaultValidators];
[REValidation registerDefaultErrorMessages];

NSString *emailString = @"test#@example.com";
NSArray *errors = [REValidation validateObject:emailString name:@"Email" validators:@[ @"presence", @"length(3, 20)", @"email" ]];

for (NSError *error in errors)
    NSLog(@"Error: %@", error.localizedDescription);

// Alternatively you can use REValidator instances
//
NSString *testString = @"";
errors = [REValidation validateObject:testString name:@"Test string" validators:@[ [REPresenceValidator validator], [RELengthValidator validatorWithParameters:@{ @"min": @3, @"max": @10}] ]];

for (NSError *error in errors)
    NSLog(@"Error: %@", error.localizedDescription);
```

It's easy to implement a custom validator, you need to subclass from `REValidator` and implement three methods:

```objective-c
+ (NSString *)name;
+ (NSDictionary *)parseParameterString:(NSString *)string;
+ (NSError *)validateObject:(NSString *)object variableName:(NSString *)name parameters:(NSDictionary *)parameters;
```

For example:

```objective-c
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
```

It's possible to add validations without subclassing `REValidator` class using inline validations. Here's an example that shows how to use inline validations with [RETableViewManager](https://github.com/romaonthego/RETableViewManager):

```objective-c
REValidator *nameValidator = [REValidator validator];
nameValidator.inlineValidation = ^NSError *(NSString *string, NSString *name) {
    if ([string componentsSeparatedByString:@" "].count < 2) {
        return [NSError errorWithDomain:@"" code:0 userInfo:@{NSLocalizedDescriptionKey: @"Please enter first and last name."}];
    }
    return nil;
};

RETextItem *nameItem = [RETextItem itemWithTitle:@"" value:self.contact.name placeholder:@"First & Last Name"];
nameItem.autocapitalizationType = UITextAutocapitalizationTypeWords;
nameItem.validators = @[nameValidator];
```

## Contact

Roman Efimov

- https://github.com/romaonthego
- https://twitter.com/romaonthego
- romefimov@gmail.com

## License

REValidation is available under the MIT license.

Copyright © 2013 Roman Efimov.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
