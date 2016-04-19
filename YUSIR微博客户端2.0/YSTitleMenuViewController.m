//
//  YSTitleMenuViewController.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/17.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSTitleMenuViewController.h"

@interface YSTitleMenuViewController ()

@end

@implementation YSTitleMenuViewController
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
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.contentView.backgroundColor = [UIColor grayColor];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"好友圈";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"群微博";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"特别关注";
    }else if (indexPath.row == 3) {
        cell.textLabel.text = @"周边微博";
    }else if (indexPath.row == 4) {
        cell.textLabel.text = @"个人主页";
    }

    
    return cell;
}
@end

