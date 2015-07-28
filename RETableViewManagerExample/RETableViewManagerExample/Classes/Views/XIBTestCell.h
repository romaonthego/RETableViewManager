//
//  XIBTestCell.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 8/11/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETableViewCell.h"
#import "XIBTestItem.h"

@interface XIBTestCell : RETableViewCell

@property (strong, readwrite, nonatomic) IBOutlet UILabel *testLabel;
@property (strong, readwrite, nonatomic) XIBTestItem *testItem;

@end
