//
// RETextItem.h
// RETableViewManager
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

#import "RETableViewItem.h"

@interface RETextItem : RETableViewItem

// Data and values
//
@property (copy, readwrite, nonatomic) NSString *value;
@property (copy, readwrite, nonatomic) NSString *placeholder;

// TextField
//
@property (assign, readwrite, nonatomic) UITextFieldViewMode clearButtonMode;        // default is UITextFieldViewModeNever
@property (assign, readwrite, nonatomic) BOOL clearsOnBeginEditing;                   // default is NO which moves cursor to location clicked. if YES, all text cleared

@property (assign, readwrite, nonatomic) NSUInteger charactersLimit;                   // characters limit


// Keyboard
//
@property (assign, readwrite, nonatomic) UITextAutocapitalizationType autocapitalizationType; // default is UITextAutocapitalizationTypeSentences
@property (assign, readwrite, nonatomic) UITextAutocorrectionType autocorrectionType;         // default is UITextAutocorrectionTypeDefault
@property (assign, readwrite, nonatomic) UITextSpellCheckingType spellCheckingType NS_AVAILABLE_IOS(5_0); // default is UITextSpellCheckingTypeDefault;
@property (assign, readwrite, nonatomic) UIKeyboardType keyboardType;                         // default is UIKeyboardTypeDefault
@property (assign, readwrite, nonatomic) UIKeyboardAppearance keyboardAppearance;             // default is UIKeyboardAppearanceDefault
@property (assign, readwrite, nonatomic) UIReturnKeyType returnKeyType;                       // default is UIReturnKeyDefault (See note under UIReturnKeyType enum)
@property (assign, readwrite, nonatomic) BOOL enablesReturnKeyAutomatically;                  // default is NO (when YES, will automatically disable return key when text widget has zero-length contents, and will automatically enable when text widget has non-zero-length contents)
@property (assign, readwrite, nonatomic) BOOL secureTextEntry;                                // default is NO

@property (copy, readwrite, nonatomic) void (^onBeginEditing)(RETextItem *item);
@property (copy, readwrite, nonatomic) void (^onEndEditing)(RETextItem *item);
@property (copy, readwrite, nonatomic) void (^onChange)(RETextItem *item);
@property (copy, readwrite, nonatomic) void (^onReturn)(RETextItem *item);
@property (copy, readwrite, nonatomic) BOOL (^onChangeCharacterInRange)(RETextItem *item, NSRange range, NSString *replacementString);


+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value;
+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value  placeholder:(NSString *)placeholder;
- (id)initWithTitle:(NSString *)title value:(NSString *)value;
- (id)initWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder;

@end
