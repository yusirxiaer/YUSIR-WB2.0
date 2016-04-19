//
//  YSRightButtonViewController.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/17.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSRightButtonViewController.h"

@interface YSRightButtonViewController ()

@end

@implementation YSRightButtonViewController
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.contentView.backgroundColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"雷达";
        cell.imageView.image = [UIImage imageNamed:@"navigationbar_icon_radar_aperture"];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"扫一扫";
        cell.imageView.image = [UIImage imageNamed:@"navigationbar_pop_highlighted"];
    }
    
    return cell;
}

@end
