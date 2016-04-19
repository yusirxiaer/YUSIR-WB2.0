//
//  YSMeViewController.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/9.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSMeViewController.h"

#import "YSMeSetViewController.h"
@interface YSMeViewController ()

@end

@implementation YSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupNavigationBar {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
   
}
-(void)rightButtonClick{
    NSLog(@"rightclick");
    YSMeSetViewController *setVC = [[YSMeSetViewController alloc] initWithNibName:@"YSMeSetViewController" bundle:[NSBundle mainBundle]];
//
//    [self presentViewController:setVC animated:YES completion:nil];
    [self.navigationController pushViewController:setVC animated:YES];
}
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 3;
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 2;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YSResusable" ];
//    //    forIndexPath:indexPath];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"YSResusable"];
//    }
//    
////    if (indexPath.row == 0) {
////        UIImageView *imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 60, 60)];
////        
////        imageViewIcon.image = [UIImage imageNamed:@"messagescenter_at"];
////        imageViewIcon.layer.cornerRadius = 30;
////        [cell.contentView addSubview:imageViewIcon];
////        // 添加子view
////        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.bounds.size.width-200, 10, 80, 40)];
////        nameLabel.text = @"@我的";
////        [cell.contentView addSubview:nameLabel];
////        //        + (instancetype)constraintWithItem:(id)view1
////        //                                 attribute:(NSLayoutAttribute)attr1
////        //                                 relatedBy:(NSLayoutRelation)relation
////        //                                    toItem:(id)view2
////        //                                 attribute:(NSLayoutAttribute)attr2
////        //                                multiplier:(CGFloat)multiplier
////        //                                  constant:(CGFloat)c
////        //        参数的意义
////        //        view1	左手边的受约束视图
////        //        attr1	左手边的受约束视图的参考参数
////        //        relation	约束的关系
////        //        view2	右手边的受约束视图
////        //        multiplier	The constant multiplied with the attribute on the right-hand side of the constraint as part of getting the modified attribute.
////        //        attr2	The constant added to the multiplied attribute value on the right-hand side of the constraint to yield the final modified attribute.
////    }
////    
////    if (indexPath.row == 1) {
////        UIImageView *imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 60, 60)];
////        imageViewIcon.image = [UIImage imageNamed:@"messagescenter_comments"];
////        imageViewIcon.layer.cornerRadius = 30;
////        [cell.contentView addSubview:imageViewIcon];
////        // 添加子view
////        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.bounds.size.width-200, 10, 80, 40)];
////        nameLabel.text = @"评论";
////        [cell.contentView addSubview:nameLabel];
////        
////          }
////    
////    if (indexPath.row == 2) {
////        UIImageView *imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 60, 60)];
////        imageViewIcon.image = [UIImage imageNamed:@"messagescenter_good"];
////        imageViewIcon.layer.cornerRadius = 30;
////        [cell.contentView addSubview:imageViewIcon];
////        // 添加子view
////        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.bounds.size.width-200, 10, 80, 40)];
////        nameLabel.text = @"赞";
////        [cell.contentView addSubview:nameLabel];
////        
////    }
////    
////    
////    if (indexPath.row == 3) {
////        UIImageView *imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 60, 60)];
////        imageViewIcon.image = [UIImage imageNamed:@"messagescenter_subscription"];
////        imageViewIcon.layer.cornerRadius = 30;
////        [cell.contentView addSubview:imageViewIcon];
////        // 添加子view
////        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.bounds.size.width-200, 10, 80, 40)];
////        nameLabel.text = @"订阅消息";
////        [cell.contentView addSubview:nameLabel];
////        
////       
////        
////    }
////    
//    // Configure the cell...
//    
//    return cell;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 60;
//}
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 100;
//}








@end









