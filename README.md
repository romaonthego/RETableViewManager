# RETableViewManager

Data driven content manager for UITableView. It allows to manage content of UITableView with ease, both forms and lists.
In its core `RETableViewManager` supports reusable cells based on corresponding data object class.
The general idea is to allow developers use their own `UITableView` and `UITableViewController` instances, 
providing a layer that synchronizes data and cell appereance.

_This is still in the early stages of development and it's highly not recommended to use it in production apps._

![Screenshot of RETableViewManager](https://github.com/romaonthego/RETableViewManager/raw/master/Screenshot.png "RETableViewManager Screenshot")

## Requirements
* Xcode 4.5 or higher
* Apple LLVM compiler
* iOS 5.0 or higher
* ARC

## Example Usage

``` objective-c
// Create manager and assign it to be the delegate and datasource of your UITableView
//
_tableViewManager = [[RETableViewManager alloc] init];
self.tableView.delegate = _tableViewManager;
self.tableView.dataSource = _tableViewManager;

// Add section
//
RETableViewSection *section = [[RETableViewSection alloc] initWithHeaderTitle:@"Test"];
[_tableViewManager addSection:section];

// Add simple string item
//
[section addItem:@"Test"];

// Add string cell with disclosure indicator
//
[section addItem:[RETableViewItem itemWithTitle:"String cell" accessoryType:UITableViewCellAccessoryDisclosureIndicator actionBlock:^(RETableViewItem *item) {
    NSLog(@"Test: %@", item);
}]];

// Add editable table cell (using UITextField)
//
[section addItem:[RETextItem itemWithTitle:@"Enter text" value:@""]];

// Add bool value cell (using UISwitch)
//
[section addItem:[REBoolItem itemWithTitle:@"Switch test" value:YES actionBlock:^(REBoolItem *item) {
    NSLog(@"Value: %i", item.value);
}]];

// Add radio cell (options)
//
__typeof (&*self) __weak weakSelf = self;
RERadioItem *optionItem = [RERadioItem itemWithTitle:@"Radio" value:@"Option 4" actionBlock:^(RETableViewItem *item) {
  [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];

  // Generate sample options
  //
  NSMutableArray *options = [[NSMutableArray alloc] init];
  for (NSInteger i = 1; i < 40; i++)
      [options addObject:[NSString stringWithFormat:@"Option %i", i]];

  // Present options controller
  //
  RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options completionHandler:^(RETableViewItem *selectedItem) {
      item.detailLabelText = selectedItem.title;
      [weakSelf.tableView reloadRowsAtIndexPaths:@[item.indexPath] withRowAnimation:UITableViewRowAnimationNone];
  }];
  [weakSelf.navigationController pushViewController:optionsController animated:YES];
}];
[section addItem:optionItem];


// Add another section
//
RETableViewSection *section2 = [[RETableViewSection alloc] initWithHeaderTitle:@"Section 2"];
section2.footerTitle = @"Hey, I'm a footer";
[_tableViewManager addSection:section2];

// It's super easy to create custom mappings, for example
// this how all NSString objects are being matched with RETableViewStringCell
//
[_tableViewManager mapObjectClass:@"NSString" toTableViewCellClass:@"RETableViewStringCell"];
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
