# REFormattedNumberField

UITextField subclass that allows numeric input in a predefined format.

<img src="https://github.com/romaonthego/REFormattedNumberField/raw/master/Screenshot.png?2" alt="REFormattedNumberField Screenshot" width="320" height="568" />

## Requirements
* Xcode 5 or higher
* Apple LLVM compiler
* iOS 6.0 or higher
* ARC

## Demo

Build and run the `REFormattedNumberFieldExample` project in Xcode to see `REFormattedNumberField` in action.

## Installation

### CocoaPods

The recommended approach for installating `REFormattedNumberField` is via the [CocoaPods](http://cocoapods.org/) package manager, as it provides flexible dependency management and dead simple installation.
For best results, it is recommended that you install via CocoaPods >= **0.24.0** using Git >= **1.8.0** installed via Homebrew.

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

Edit your Podfile and add REFormattedNumberField:

``` bash
platform :ios, '6.0'
pod 'REFormattedNumberField', '~> 1.1'
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

All you need to do is drop `REFormattedNumberField` files into your project, and add `#include "REFormattedNumberField.h"` to the top of classes that will use it.

## Example Usage

Pretty much all you need is just to specify `format` NSString, where `X` are digits and all other characters are separators.

``` objective-c
REFormattedNumberField *phoneField1 = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(20, 20, 280, 30)];
phoneField1.format = @"(XXX) XXX-XXXX";
[self.view addSubview:phoneField1];

REFormattedNumberField *phoneField2 = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(20, 80, 280, 30)];
phoneField2.format = @"+X (XXX) XXX-XXXX";
[self.view addSubview:phoneField2];

REFormattedNumberField *ccField = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(20, 140, 280, 30)];
ccField.format = @"XXXX XXXX XXXX XXXX";
[self.view addSubview:ccField];

REFormattedNumberField *ccExpirationField = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(20, 200, 280, 30)];
ccExpirationField.format = @"XX/XX";
[self.view addSubview:ccExpirationField];
```

## Contact

Roman Efimov

- https://github.com/romaonthego
- https://twitter.com/romaonthego
- romefimov@gmail.com

## License

REFormattedNumberField is available under the MIT license.

Copyright © 2013 Roman Efimov.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
