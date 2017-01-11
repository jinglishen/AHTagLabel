//
//  TagsViewController.m
//  TestProject
//
//  Created by 沈立京 on 2016/12/22.
//  Copyright © 2016年 Benster. All rights reserved.
//

#import "TagsViewController.h"

#import "TagsCell.h"

@interface TagsViewController ()

@property (nonatomic, strong) NSArray *tags;

@end

@implementation TagsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *array = @[
                      @{
                          @"ENABLED": @(false),
                          @"CATEGORY": @"budget",
                          @"TITLE": @"1K以下"
                          },
                      @{
                          @"ENABLED": @(false),
                          @"CATEGORY": @"budget",
                          @"TITLE": @"1K-1W"
                          },
                      @{
                          @"ENABLED": @(false),
                          @"CATEGORY": @"budget",
                          @"TITLE": @"1W-2W"
                          },
                      @{
                          @"ENABLED": @(false),
                          @"CATEGORY": @"budget",
                          @"TITLE": @"2W-5W"
                          },
                      @{
                          @"ENABLED": @(false),
                          @"CATEGORY": @"budget",
                          @"TITLE": @"10W+"
                          },
                      @{
                          @"ENABLED": @(false),
                          @"CATEGORY": @"budget",
                          @"TITLE": @"自定义"
                          },
                      @{
                          @"ENABLED": @(false),
                          @"CATEGORY": @"budget",
                          @"TITLE": @"自定义"
                          },
                      @{
                          @"ENABLED": @(false),
                          @"CATEGORY": @"budget",
                          @"TITLE": @"自定义"
                          },
                      @{
                          @"ENABLED": @(false),
                          @"CATEGORY": @"budget",
                          @"TITLE": @"自定义"
                          },
                      @{
                          @"ENABLED": @(false),
                          @"CATEGORY": @"budget",
                          @"TITLE": @"自定义"
                          },
                      @{
                          @"ENABLED": @(false),
                          @"CATEGORY": @"budget",
                          @"TITLE": @"自定义"
                          },
                      @{
                          @"ENABLED": @(false),
                          @"CATEGORY": @"budget",
                          @"TITLE": @"自定义自定义自定义自定义自定义自定义自定义自定义自定义自定义自定义自定义自定义自定义自定义自定义自定义自定义自定义自定义自定义自定义自定义自定义"
                          },
                      ];
    
    NSMutableArray *tags = [NSMutableArray new];
    for (NSDictionary *tagDict in array) {
        AHTag *tag = [tagDict tag];
        [tags addObject:tag];
    }
    
    self.tags = tags;
    
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TagsCell" bundle:nil]
         forCellReuseIdentifier:@"Cell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TagsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tagsLabel.tagMinWidth = 80;
    cell.tagsLabel.labelCornerRadius = 5;
    
    cell.tagsLabel.tags = self.tags;

    return cell;
}

@end
