forked from [romaonthego/RETableViewManager](https://github.com/romaonthego/RETableViewManager)

#Install

		pod "RETableViewManager", :git => "https://github.com/eleven-huang/RETableViewManager.git"
		
#Changes
##1. Add REFloatingNumberItem
You may need to input floating numbers sometimes, such as cash, bitcoin.
		
		
		self.floatingNumberItem = [REFloatingNumberItem itemWithTitle:@"Cash" value:@"" placeholder:@"＄"];

![image](floating number.png)

##2. Can disable editting on textfield now


		self.textItem = [RETextItem itemWithTitle:@"Text item" value:nil placeholder:@"Text"];
		self.textItem.disable = YES;



#License

The MIT License (MIT)

Copyright (c) 2014 Yijun Huang (https://github.com/eleven-huang).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.