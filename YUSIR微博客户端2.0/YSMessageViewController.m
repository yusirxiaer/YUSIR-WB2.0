//
//  YSMessageViewController.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/10.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSMessageViewController.h"
#import "YSCommandHeader.h"
#import "UIBarButtonItem+Extension.h"
@interface YSMessageViewController ()

@end

@implementation YSMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(doSet) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)doSet{
    NSLog(@"doSet");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YSResusableCell" ];
//    forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"YSResusableCell"];
    }
    
    if (indexPath.row == 0) {
        UIImageView *imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 60, 60)];
        
        imageViewIcon.image = [UIImage imageNamed:@"messagescenter_at"];
        imageViewIcon.layer.cornerRadius = 30;
        [cell.contentView addSubview:imageViewIcon];
        // 添加子view
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.bounds.size.width-200, 10, 80, 40)];
        nameLabel.text = @"@我的";
        [cell.contentView addSubview:nameLabel];
//        + (instancetype)constraintWithItem:(id)view1
//                                 attribute:(NSLayoutAttribute)attr1
//                                 relatedBy:(NSLayoutRelation)relation
//                                    toItem:(id)view2
//                                 attribute:(NSLayoutAttribute)attr2
//                                multiplier:(CGFloat)multiplier
//                                  constant:(CGFloat)c
//        参数的意义
//        view1	左手边的受约束视图
//        attr1	左手边的受约束视图的参考参数
//        relation	约束的关系
//        view2	右手边的受约束视图
//        multiplier	The constant multiplied with the attribute on the right-hand side of the constraint as part of getting the modified attribute.
//        attr2	The constant added to the multiplied attribute value on the right-hand side of the constraint to yield the final modified attribute.

//        NSLayoutConstraint *icon_x = [NSLayoutConstraint constraintWithItem:cell.contentView  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:imageViewIcon attribute:NSLayoutAttributeRight multiplier:1 constant:5];
//         NSLayoutConstraint *icon_y = [NSLayoutConstraint constraintWithItem:cell.contentView  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imageViewIcon attribute:NSLayoutAttributeTop multiplier:1 constant:5];
//         NSLayoutConstraint *icon_h = [NSLayoutConstraint constraintWithItem:cell.contentView       attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:imageViewIcon attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
//        NSLayoutConstraint *icon_w = [NSLayoutConstraint constraintWithItem:imageViewIcon   attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:CGRectGetWidth(imageViewIcon.frame)];
//        [cell.contentView addConstraints:@[icon_x,icon_y,icon_h,icon_w]];
        
//        NSLayoutConstraint *label_x = [NSLayoutConstraint constraintWithItem:cell.contentView  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:nameLabel attribute:NSLayoutAttributeRight multiplier:1 constant:100];
//        NSLayoutConstraint *label_y = [NSLayoutConstraint constraintWithItem:cell.contentView  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:nameLabel attribute:NSLayoutAttributeTop multiplier:1 constant:45];
//        NSLayoutConstraint *label_h = [NSLayoutConstraint constraintWithItem:nameLabel       attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:CGRectGetHeight(nameLabel.frame)];
//        NSLayoutConstraint *label_w = [NSLayoutConstraint constraintWithItem:imageViewIcon   attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:CGRectGetWidth(nameLabel.frame)];
//        [cell.contentView addConstraints:@[label_x,label_y,label_h,label_w]];
    }
    
    if (indexPath.row == 1) {
        UIImageView *imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 60, 60)];
        imageViewIcon.image = [UIImage imageNamed:@"messagescenter_comments"];
        imageViewIcon.layer.cornerRadius = 30;
        [cell.contentView addSubview:imageViewIcon];
        // 添加子view
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.bounds.size.width-200, 10, 80, 40)];
        nameLabel.text = @"评论";
        [cell.contentView addSubview:nameLabel];
        
//        NSLayoutConstraint *icon_x = [NSLayoutConstraint constraintWithItem:cell.contentView  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:imageViewIcon attribute:NSLayoutAttributeRight multiplier:1 constant:5];
//        NSLayoutConstraint *icon_y = [NSLayoutConstraint constraintWithItem:cell.contentView  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imageViewIcon attribute:NSLayoutAttributeTop multiplier:1 constant:5];
//        NSLayoutConstraint *icon_h = [NSLayoutConstraint constraintWithItem:cell.contentView       attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:imageViewIcon attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
//        NSLayoutConstraint *icon_w = [NSLayoutConstraint constraintWithItem:imageViewIcon   attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:CGRectGetWidth(imageViewIcon.frame)];
//        [cell.contentView addConstraints:@[icon_x,icon_y,icon_h,icon_w]];

    }

    if (indexPath.row == 2) {
        UIImageView *imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 60, 60)];
        imageViewIcon.image = [UIImage imageNamed:@"messagescenter_good"];
        imageViewIcon.layer.cornerRadius = 30;
        [cell.contentView addSubview:imageViewIcon];
        // 添加子view
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.bounds.size.width-200, 10, 80, 40)];
        nameLabel.text = @"赞";
        [cell.contentView addSubview:nameLabel];
        
//        NSLayoutConstraint *icon_x = [NSLayoutConstraint constraintWithItem:cell.contentView  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:imageViewIcon attribute:NSLayoutAttributeRight multiplier:1 constant:5];
//        NSLayoutConstraint *icon_y = [NSLayoutConstraint constraintWithItem:cell.contentView  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imageViewIcon attribute:NSLayoutAttributeTop multiplier:1 constant:5];
//        NSLayoutConstraint *icon_h = [NSLayoutConstraint constraintWithItem:cell.contentView       attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:imageViewIcon attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
//        NSLayoutConstraint *icon_w = [NSLayoutConstraint constraintWithItem:imageViewIcon   attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:CGRectGetWidth(imageViewIcon.frame)];
//        [cell.contentView addConstraints:@[icon_x,icon_y,icon_h,icon_w]];
        
    }

    
    if (indexPath.row == 3) {
        UIImageView *imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 60, 60)];
        imageViewIcon.image = [UIImage imageNamed:@"messagescenter_subscription"];
        imageViewIcon.layer.cornerRadius = 30;
        [cell.contentView addSubview:imageViewIcon];
        // 添加子view
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.bounds.size.width-200, 10, 80, 40)];
        nameLabel.text = @"订阅消息";
        [cell.contentView addSubview:nameLabel];
        
//        NSLayoutConstraint *icon_x = [NSLayoutConstraint constraintWithItem:cell.contentView  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:imageViewIcon attribute:NSLayoutAttributeRight multiplier:1 constant:5];
//        NSLayoutConstraint *icon_y = [NSLayoutConstraint constraintWithItem:cell.contentView  attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imageViewIcon attribute:NSLayoutAttributeTop multiplier:1 constant:5];
//        NSLayoutConstraint *icon_h = [NSLayoutConstraint constraintWithItem:cell.contentView       attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:imageViewIcon attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
//        NSLayoutConstraint *icon_w = [NSLayoutConstraint constraintWithItem:imageViewIcon   attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:CGRectGetWidth(imageViewIcon.frame)];
//        [cell.contentView addConstraints:@[icon_x,icon_y,icon_h,icon_w]];
        
    }

    // Configure the cell...
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}








//纯代码手写tablecell导致这种情况，是因为并没有
//AutoLayout，估算代码都不行都是基于AutoLayout。
//需要纯代码手写AutoLayout来解决








@end











