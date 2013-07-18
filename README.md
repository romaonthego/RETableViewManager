# RETableViewManager

__Powerful data driven content manager for UITableView.__

`RETableViewManager` allows to manage the content of any `UITableView` with ease, both forms and lists. `RETableViewManager` is built on top of reusable cells technique and provides APIs for mapping any object class to any custom cell subclass.

The general idea is to allow developers to use their own `UITableView` and `UITableViewController` instances, providing a layer that synchronizes data with cell appereance.
It fully implements `UITableViewDelegate` and `UITableViewDataSource` protocols so you don't have to.

### _It is still in the early stages of development and it's highly not recommended to use it in production apps._

<img src="https://github.com/romaonthego/RETableViewManager/raw/master/Screenshot1.png" alt="RETableViewManager Screenshot" width="684" height="568" />

<img src="https://github.com/romaonthego/RETableViewManager/raw/master/Screenshot2.png" alt="RETableViewManager Screenshot" width="684" height="568" />

### Quick Example

Get your `UITableView` up and running in couple minutes:

``` objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Create the manager and assign a UITableView
    //
    _manager = [[RETableViewManager alloc] initWithTableView:self.tableView];

    // Add a section
    //
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Test"];
    [manager addSection:section];

    // Add a string
    //
    [section addItem:@"Just a simple NSString"];

    // Add a basic cell with disclosure indicator
    //
    [section addItem:[RETableViewItem itemWithTitle:"String cell" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        NSLog(@"Test: %@", item);
    }]];

    // Custom items / cells
    //
    _manager[@"CustomItem"] = @"CustomCell";

    [section addItem:[[CustomItem alloc] init]];
}
```

> RETableViewManager comes pre-packaged with extensible and ready-to-use components:

> * Text
* Bool
* Number
* Float
* Date/Time
* Long Text
* Radio option selector
* Multiple option selector
* Credit card and expiration date

Also, `RETableViewManager` provides APIs for super easy cell styling.

## Requirements
* Xcode 4.6 or higher
* Apple LLVM compiler
* iOS 6.0 or higher
* ARC

## Demo

Build and run the `RETableViewManagerExample` project in Xcode to see `RETableViewManager` in action.

## Installation

### CocoaPods

The recommended approach for installating `RETableViewManager` is via the [CocoaPods](http://cocoapods.org/) package manager, as it provides flexible dependency management and dead simple installation.
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

Edit your Podfile and add RETableViewManager:

``` bash
platform :ios, '6.0'
pod 'RETableViewManager', '~> 0.1.0'
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


## API Quickstart

<table>
  <tr><th colspan="2" style="text-align:center;">Key Classes</th></tr>
  <tr>
    <td>RETableViewManager</td>
    <td>Main manager class. Each manager has multiple <tt>RETableViewSection</tt> sections.</td>
  </tr>
  <tr>
    <td>RETableViewSection</td>
    <td>Represents sections in RETableViewManager, each section has multiple <tt>RETableViewItem</tt>.</td>
  </tr>
  <tr>
    <td>RETableViewItem</td>
    <td>RETableViewItem is the root class of most <tt>RETableViewManager</tt> item hierarchies.<br />
    Through <tt>RETableViewItem</tt>, items inherit a basic interface that communicates with <tt>RETableViewCell</tt> and <tt>RETableViewManager</tt>.</td>
  </tr>
  <tr>
    <td>RETableViewCell</td>
    <td>The <tt>RETableViewCell</tt> class defines the attributes and behavior of the cells that appear in <tt>UITableView</tt> objects.
     You should subclass <tt>RETableViewCell</tt> to obtain cell characteristics and behavior specific to your application's needs.
     By default, <tt>RETableViewCell</tt> is being mapped with <tt>RETableViewItem</tt>.</td>
  </tr>
  <tr><th colspan="2" style="text-align:center;">Styling</th></tr>
  <tr>
    <td>RETableViewCellStyle</td>
    <td>Provides style for <tt>RETableViewCell</tt> subclasses. You can define such properties as
    <tt>textFieldFont</tt>, <tt>cellHeight</tt>, <tt>backgroundImage</tt> and more.</td>
  </tr>
  <tr><th colspan="2" style="text-align:center;">Helper Controllers</th></tr>
  <tr>
    <td>RETableViewOptionsController</td>
    <td>Performs selection based on user input and provides result on completion. Should be used with RERadioItem.
    </td>
  </tr>
</table>

RETableViewManager includes a number of built-in items and cells that were mapped with each other so you don't have to.

<table>
  <tr><th colspan="3" style="text-align:center;">Built-in Items and Cells</th></tr>
  <tr>
    <th>Item Class</th>
    <th>Cell Class</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>RETextItem</td>
    <td>RETableViewTextCell</td>
    <td>Provides convenience for user text input. You can set a bunch of properties through <tt>RETextItem</tt> that you would
    normally find in <tt>UITextField</tt>.</td>
  </tr>
  <tr>
    <td>RELongTextItem</td>
    <td>RETableViewLongTextCell</td>
    <td>Provides convenience for multiline user text input. You can set a bunch of properties through <tt>RELongTextItem</tt> that you would
    normally find in <tt>UITextView</tt>.</td>
  </tr>
  <tr>
    <td>RENumberItem</td>
    <td>RETableViewNumberCell</td>
    <td>Provides convenience for user number input using <a href="https://github.com/romaonthego/REFormattedNumberField">REFormattedNumberField</a>.</td>
  </tr>
  <tr>
    <td>REBoolItem</td>
    <td>RETableViewBoolCell</td>
    <td>Provides convenience for user boolean input using <tt>UISwitch</tt>.</td>
  </tr>
  <tr>
    <td>RERadioItem</td>
    <td>RETableViewCell</td>
    <td>Provides convenience for selecting a single option using <tt>RETableViewOptionsController</tt>.</td>
  </tr>
  <tr>
    <td>REMultipleChoiceItem</td>
    <td>RETableViewCell</td>
    <td>Provides convenience for selecting multiple options using <tt>RETableViewOptionsController</tt>.</td>
  </tr>
  <tr>
    <td>REFloatItem</td>
    <td>RETableViewFloatCell</td>
    <td>Provides convenience for adjusting float values from 0.0 to 1.0.</td>
  </tr>
  <tr>
    <td>REDateTimeItem</td>
    <td>RETableViewDateTimeCell</td>
    <td>Provides convenience for adjusting NSDate object.</td>
  </tr>
  <tr>
    <td>RECreditCardItem</td>
    <td>RETableViewCreditCardCell</td>
    <td>Provides convenience for user credit card input. Allows to enter credit card number, expiration date and security code all in one table cell.</td>
  </tr>
</table>

## Examples

### Creating Sections Example

Section without a title:

``` objective-c
RETableViewSection *section = [RETableViewSection section];
[_tableViewManager addSection:section];
```

Section with a title:

``` objective-c
RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Header"];
[_tableViewManager addSection:section];
```

Section with a title and a footer:

``` objective-c
RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Header" footerTitle:@"Footer"];
[_tableViewManager addSection:section];
```

Section with a custom title view:

``` objective-c
RETableViewSection *section = [RETableViewSection sectionWithHeaderView:myCustomSectionHeaderView];
[_tableViewManager addSection:section];
```

### Item to Cell Mapping Example

It's super easy to create custom mappings, the concept is similiar to `UICollectionView`.
For example, this how all `NSString` objects are being mapped to `RETableViewCell`:

``` objective-c
_tableViewManager[@"NSString"] = @"RETableViewCell";
```

If you take a look at [RETableViewManager Source Code](https://github.com/romaonthego/RETableViewManager/blob/master/RETableViewManager/RETableViewManager.m) you may
find out how default mapping is performed:

``` objective-c
- (void)registerDefaultClasses
{
    self[@"__NSCFConstantString"] = @"RETableViewCell";
    self[@"__NSCFString"] = @"RETableViewCell";
    self[@"NSString"] = @"RETableViewCell";
    self[@"RETableViewItem"] = @"RETableViewCell";
    self[@"RERadioItem"] = @"RETableViewOptionCell";
    self[@"REBoolItem"] = @"RETableViewBoolCell";
    self[@"RETextItem"] = @"RETableViewTextCell";
    self[@"RELongTextItem"] = @"RETableViewLongTextCell";
    self[@"RENumberItem"] = @"RETableViewNumberCell";
    self[@"REFloatItem"] = @"RETableViewFloatCell";
    self[@"REDateTimeItem"] = @"RETableViewDateTimeCell";
    self[@"RECreditCardItem"] = @"RETableViewCreditCardCell";
    self[@"REMultipleChoiceItem"] = @"RETableViewOptionCell";
}
```

### Text (UITextField) and Number (REFormattedNumberField) Item Example

``` objective-c
// Create the manager and assign it to be the delegate and datasource of your UITableView
//
_tableViewManager = [[RETableViewManager alloc] init];
self.tableView.delegate = _tableViewManager;
self.tableView.dataSource = _tableViewManager;

// Add a section
//
RETableViewSection *section = [[RETableViewSection alloc] initWithHeaderTitle:@"Test"];
[_tableViewManager addSection:section];

_textItem = [RETextItem itemWithTitle:@"Enter text" value:@""];
[section addItem:_textItem];

_numberItem = [RENumberItem itemWithTitle:@"Enter text" value:@"" placeholder:@"(123) 456-7890" format:@"(XXX) XXX-XXXX"];
[section addItem:_numberItem];
```

You can read `_textItem.value` and `_numberItem.value` later whenever you need them.

### Bool Item (UISwitch) Example

``` objective-c
// Create the manager and assign it to be the delegate and datasource of your UITableView
//
_tableViewManager = [[RETableViewManager alloc] init];
self.tableView.delegate = _tableViewManager;
self.tableView.dataSource = _tableViewManager;

// Add a section
//
RETableViewSection *section = [[RETableViewSection alloc] initWithHeaderTitle:@"Test"];
[_tableViewManager addSection:section];

// Add a bool value cell (using UISwitch)
//
[section addItem:[REBoolItem itemWithTitle:@"Switch test" value:YES switchValueChangeHandler:^(REBoolItem *item) {
    NSLog(@"Value: %i", item.value);
}]];
```

### Radio (RETableViewOptionsController) Item Example

``` objective-c
// Create the manager and assign it to be the delegate and datasource of your UITableView
//
_tableViewManager = [[RETableViewManager alloc] initWithTableView:self.tableView];

// Add a section
//
RETableViewSection *section = [[RETableViewSection alloc] initWithHeaderTitle:@"Test"];
[_tableViewManager addSection:section];

// Add radio cell (options)
//
__typeof (&*self) __weak weakSelf = self;
RERadioItem *optionItem = [RERadioItem itemWithTitle:@"Radio" value:@"Option 4" selectionHandler:^(RERadioItem *item) {
  [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];

  // Generate sample options
  //
  NSMutableArray *options = [[NSMutableArray alloc] init];
  for (NSInteger i = 1; i < 40; i++)
      [options addObject:[NSString stringWithFormat:@"Option %i", i]];

  // Present options controller
  //
  RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options completionHandler:^(RETableViewItem *selectedItem) {
      item.value = selectedItem.title;
      [weakSelf.tableView reloadRowsAtIndexPaths:@[item.indexPath] withRowAnimation:UITableViewRowAnimationNone];
  }];
  [weakSelf.navigationController pushViewController:optionsController animated:YES];
}];
[section addItem:optionItem];
```

### Float Item (UISlider) Example

``` objective-c
// Create the manager and assign it to be the delegate and datasource of your UITableView
//
_tableViewManager = [[RETableViewManager alloc] init];
self.tableView.delegate = _tableViewManager;
self.tableView.dataSource = _tableViewManager;

// Add a section
//
RETableViewSection *section = [[RETableViewSection alloc] initWithHeaderTitle:@"Test"];
[_tableViewManager addSection:section];

// Add a float item
//
[section addItem:[REFloatItem itemWithTitle:@"Float item" value:0.3 sliderValueChangeHandler:^(REFloatItem *item) {
    NSLog(@"Value: %f", item.value);
}]];
```

### Custom Cells

`RETableViewManager` allows to map custom objects to custom cells. In order to map your custom object (an item) to a cell,
simply write:

```objective-c
_manager[@"CustomItem"] = @"CustomCell";
```

## Contact

Roman Efimov

- https://github.com/romaonthego
- https://twitter.com/romaonthego
- romefimov@gmail.com

## License

RETableViewManager is available under the MIT license.

Copyright © 2013 Roman Efimov.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
