//
//  YSHomeViewController.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/7.
//  Copyright © 2016年 YUSIR. All rights reserved.
//问题在于重用cell图片没法更新

#import "YSHomeViewController.h"
#import "YSCommandHeader.h"
#import "YSWeiboInfo.h"
#import "YSAccount.h"
#import "YSAccountTool.h"
#import "YSWeiboInfoTableViewCell.h"
#import "YSRepostsViewController.h"
#import "YSCommentViewController.h"
#import "YSAttitudesViewController.h"
#import "AppDelegate.h"
#import "YSNetworkTool.h"
#import "LBProgressHUD.h"//第三方loading
#import "UIView+Extension.h"
#import "YSDropDownMenu.h"
#import "YSTitleMenuViewController.h"
#import "YSRightButtonViewController.h"
@interface YSHomeViewController ()<YSDropDownMenuDelegate>

@property (strong,nonatomic)NSMutableArray *weiboInfoArray;
@property (strong,nonatomic) UIButton *leftButton;
@end

@implementation YSHomeViewController

-(NSMutableArray *)weiboInfoArray{
    if (!_weiboInfoArray) {
        _weiboInfoArray = [NSMutableArray array];
        
    }
    return _weiboInfoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    self.view.backgroundColor = [UIColor orangeColor];
    [self setupNavigationBar];
    [self setupTableView];
    [self loadUserWeiboData:YSPublicTimelineURL];
    
    [self setupPullToRefresh];
    [self setupBottomButtonLoading];
    }
#pragma mark - 配置tableview
- (void)setupNavigationBar {
    // 左边按钮
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_friendsearch"] forState:UIControlStateNormal];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] forState:UIControlStateHighlighted];
    self.leftButton.frame = (CGRect){CGPointZero, self.leftButton.currentBackgroundImage.size};
    [self.leftButton addTarget:self action:@selector(leftButtonClickedFriendsMessage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    
    
    // 右边按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_icon_radar"] forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_icon_radar_highlighted"] forState:UIControlStateHighlighted];
    rightButton.frame = (CGRect){CGPointZero, rightButton.currentBackgroundImage.size};
    // 监听标题点击
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
  
    
    /* 中间的标题按钮 */
    //    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *titleButton = [[UIButton alloc] init];
    titleButton.width = 150;
    titleButton.height = 30;
    //    titleButton.backgroundColor = HWRandomColor;
    
    // 设置图片和文字
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
//        titleButton.imageView.backgroundColor = [UIColor redColor];
//        titleButton.titleLabel.backgroundColor = [UIColor blueColor];
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    
    // 监听标题点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    // 如果图片的某个方向上不规则，比如有突起，那么这个方向就不能拉伸
}
/**
 *  标题点击
 */
- (void)titleClick:(UIButton *)titleButton
{
    // 1.创建下拉菜单
    YSDropDownMenu *menu = [YSDropDownMenu menu];
    menu.delegate = self;
    
    // 2.设置内容
    YSTitleMenuViewController *vc = [[YSTitleMenuViewController alloc] init];
    vc.view.height = 170;
    vc.view.width = 150;
    menu.contentController = vc;
    
    // 3.显示
    [menu showFrom:titleButton OffsetX:-30  OffsetY:-25];
}
/**
 *  标题点击
 */
- (void)rightButtonClick:(UIButton *)rightButton
{
    // 1.创建下拉菜单
    YSDropDownMenu *menu = [YSDropDownMenu menu];
    menu.delegate = self;
    
    // 2.设置内容
    YSRightButtonViewController *vc = [[YSRightButtonViewController alloc] init];
    vc.view.height = 80;
    vc.view.width = 120;
    menu.contentController = vc;
    
    // 3.显示
    [menu showFrom:rightButton OffsetX:-35 OffsetY:-5];
}


-(void)leftButtonClickedFriendsMessage{
    [LBProgressHUD showHUDto:self.view animated:YES];
    [_weiboInfoArray removeAllObjects];
    YSAccount *account = [YSAccountTool account];
    
    // 1.构造参数字典
    NSDictionary *dict = @{
                           @"access_token" : account.access_token,
                           
                           };
    
    // 2.调用工具发起请求
    [YSNetworkTool GETWithURL:YSFriendsTimelineURL params:dict completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"-------------%zd",httpResponse.statusCode);
        
        if (httpResponse.statusCode == 200) {
            
            //JSON解析
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];                        NSLog(@"\ndataDict : %@", dataDict);
            // 调用字典转模型
            NSArray *objectArray = [self objectWithKeyValues:dataDict];
            // 将新数据加载在旧数据的后面，新建的数组来实现前插和尾插
            NSMutableArray *tmpArray = [NSMutableArray array];
            [tmpArray addObjectsFromArray:self.weiboInfoArray];
            [tmpArray addObjectsFromArray:objectArray];
            self.weiboInfoArray = tmpArray;
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
                //重新加载table view显示数据
                [self.tableView reloadData];
                // 显示最新微博的数量
                [self showNewWeiboInfoCount:objectArray.count+1];
            });
            
        }else{
            NSLog(@"请求数据失败：%@",error.localizedDescription);
        }
    }];


//    // 1.1拼接参数(GET方法的请求URL)
//    NSString *urlString = [NSString stringWithFormat:@"%@?access_token=%@", YSFriendsTimelineURL ,account.access_token];
//    
//    NSLog(@"public_urlstring:%@",urlString);
//    NSURL *url = [NSURL URLWithString:urlString];
//    
//    // 2.1创建request(默认为GET方式请求数据)
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    // 3.获取URLSession
//    NSURLSession *urlsession = [NSURLSession sharedSession];
//    
//    // 4.利用session创建一个数据加载服务
//    NSURLSessionDataTask *dataTask = [urlsession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//        NSLog(@"-------------%zd",httpResponse.statusCode);
//        
//        if (httpResponse.statusCode == 200) {
//            
//            //JSON解析
//            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];                        NSLog(@"\ndataDict : %@", dataDict);
//            
//            // 调用字典转模型
//            NSArray *objectArray = [self objectWithKeyValues:dataDict];
//            // 将新数据加载在旧数据的后面，新建的数组来实现前插和尾插
//            NSMutableArray *tmpArray = [NSMutableArray array];
//            [tmpArray addObjectsFromArray:self.weiboInfoArray];
//            [tmpArray addObjectsFromArray:objectArray];
//            self.weiboInfoArray = tmpArray;
//            
//            dispatch_sync(dispatch_get_main_queue(), ^{
//                [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
//                //重新加载table view显示数据
//                [self.tableView reloadData];
//                // 显示最新微博的数量
//                [self showNewWeiboInfoCount:objectArray.count+1];
//            });
//        }else{
//            NSLog(@"请求数据失败：%@",error.localizedDescription);
//        }
//    }];
//    // 恢复数据加载任务
//    [dataTask resume];
    

}
/**
 *  配置table view
 */
- (void)setupTableView {
    [LBProgressHUD showHUDto:self.view animated:YES];
//    下面这个属性是分割线的Style
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150;
//    刚开始就隐藏tableView可以创造等待界面，知道加载完再显示
//    self.tableView.hidden = YES;
    
}

#pragma mark - 获取用户微博数据处理
/**
 *  获取用户微博信息
 *  url：https://api.weibo.com/2/statuses/public_timeline.json
 */
- (void)loadUserWeiboData:(NSString *)WeiboUrl{
    YSAccount *account = [YSAccountTool account];
    // 1.构造参数字典
    NSDictionary *dict = @{
                           @"access_token" : account.access_token
                           
                           };
    
    // 2.调用工具发起请求
    [YSNetworkTool GETWithURL:WeiboUrl params:dict completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"-------------%zd",httpResponse.statusCode);
        
        
        if (httpResponse.statusCode == 200) {
            
            //JSON解析
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];                        NSLog(@"\ndataDict : %@", dataDict);
            //            [self.refreshControl endRefreshing];
            
            // 调用字典转模型
            NSArray *objectArray =[self objectWithKeyValues:dataDict];
            
            // 将新数据加载在旧数据的前面
            NSMutableArray *tmpArray = [NSMutableArray array];
            [tmpArray addObjectsFromArray:objectArray];
            [tmpArray addObjectsFromArray:self.weiboInfoArray];
            self.weiboInfoArray = tmpArray;
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                //            停止第三方loading
                [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
                //                self.tableView.hidden = NO;
                // 重新加载table view显示数据
                [self.tableView reloadData];
                
            });
            
            
        }else{
            NSLog(@"请求数据失败：%@",error.localizedDescription);
        }

    }];
    
//    // 1.1拼接参数(GET方法的请求URL)
//    NSString *urlString = [NSString stringWithFormat:@"%@?access_token=%@", WeiboUrl ,account.access_token];
//    
//    NSLog(@"public_urlstring:%@",urlString);
//    NSURL *url = [NSURL URLWithString:urlString];
//    
//    // 2.1创建request(默认为GET方式请求数据)
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    // 3.获取URLSession
//    NSURLSession *urlsession = [NSURLSession sharedSession];
//    // 4.利用session创建一个数据加载服务
//    NSURLSessionDataTask *dataTask = [urlsession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//        NSLog(@"-------------%zd",httpResponse.statusCode);
//        
//
//        if (httpResponse.statusCode == 200) {
//            
//            //JSON解析
//            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];                        NSLog(@"\ndataDict : %@", dataDict);
//            //            [self.refreshControl endRefreshing];
//           
//            // 调用字典转模型
//            NSArray *objectArray =[self objectWithKeyValues:dataDict];
//            
//            // 将新数据加载在旧数据的前面
//            NSMutableArray *tmpArray = [NSMutableArray array];
//            [tmpArray addObjectsFromArray:objectArray];
//            [tmpArray addObjectsFromArray:self.weiboInfoArray];
//            self.weiboInfoArray = tmpArray;
//
//            dispatch_sync(dispatch_get_main_queue(), ^{
////            停止第三方loading
//            [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
//                
////                self.tableView.hidden = NO;
//                // 重新加载table view显示数据
//                [self.tableView reloadData];
//                
//            });
//            
//            
//        }else{
//            NSLog(@"请求数据失败：%@",error.localizedDescription);
//        }
//    }];
//    // 恢复数据加载任务
//    [dataTask resume];

}


#pragma mark - 字典转模型
- (NSArray*)objectWithKeyValues:(NSDictionary *)dict {
    NSMutableArray *objectArray = [NSMutableArray array];
    NSMutableArray *tmpweiboInfoArray = dict[@"statuses"];
    //            JSON转模型
    for(NSDictionary *tmpDict in tmpweiboInfoArray)
    {
        //                逐一取出需要的值
        YSWeiboInfo *weiboInfo =[[YSWeiboInfo alloc]init];
        
        weiboInfo.idstr = tmpDict[@"id"];
        weiboInfo.text = tmpDict[@"text"];
        weiboInfo.source = tmpDict[@"source"];
        weiboInfo.created_at = [tmpDict valueForKey:@"created_at"];
        weiboInfo.reposts_count = [[tmpDict valueForKey:@"reposts_count"] intValue];
        weiboInfo.comments_count = [[tmpDict valueForKey: @"comments_count"] intValue];
        weiboInfo.attitudes_count = [[tmpDict valueForKey:@"attitudes_count"]intValue];
        //        weiboInfo.retweetedStatus = [tmpDict valueForKey:@"retweeted_status"];
        //        可以理解为取出子字典
        NSDictionary *userDict = [tmpDict valueForKey:@"user"];
        weiboInfo.name = [userDict valueForKey:@"name"];
        weiboInfo.avatar_large = [userDict valueForKey:@"avatar_large"];
        
        NSLog(@"weiboinfo:%@",weiboInfo);
        [objectArray addObject:weiboInfo];
        //        [self.weiboInfoArray addObject:weiboInfo];
    }
    return objectArray;
    
}



#pragma mark - 页脚按钮点击下部加载数据
-(void)setupBottomButtonLoading{
//    原始的更新
//    [self.refreshControl beginRefreshing];
    //footview底部加载更多
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(0, 0, SCREEN_WIDTH, 30);
    [button setTitle:@"点击加载更多" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightGrayColor];
    button.tintColor  = [UIColor blackColor];
    [button addTarget:self action:@selector(bottomButtonLoadMore) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = button;
//    隐藏tableFooterView
    self.tableView.tableFooterView.hidden = YES;

}

-(void)bottomButtonLoadMore{
    [self ButtonloadMoreWeiboInfoDataFromBottom];
}
//底部按键从下方加载数据
- (void)ButtonloadMoreWeiboInfoDataFromBottom {
    YSAccount *account = [YSAccountTool account];
    [LBProgressHUD showHUDto:self.view animated:YES];

    // 1.构造参数字典
    NSDictionary *dict = @{
                           @"access_token" : account.access_token,
                           
                           };
    
    // 2.调用工具发起请求
    [YSNetworkTool GETWithURL:YSPublicTimelineURL params:dict completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"-------------%zd",httpResponse.statusCode);
        
        if (httpResponse.statusCode == 200) {
            
            //JSON解析
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];                        NSLog(@"\ndataDict : %@", dataDict);
            [self.refreshControl endRefreshing];
            // 调用字典转模型
            NSArray *objectArray = [self objectWithKeyValues:dataDict];
            // 将新数据加载在旧数据的后面，新建的数组来实现前插和尾插
            NSMutableArray *tmpArray = [NSMutableArray array];
            [tmpArray addObjectsFromArray:self.weiboInfoArray];
            [tmpArray addObjectsFromArray:objectArray];
            self.weiboInfoArray = tmpArray;
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
                //                 重新加载table view显示数据
                [self.tableView reloadData];
                // 显示最新微博的数量
                [self showNewWeiboInfoCount:objectArray.count+1];
            });
            
        }else{
            NSLog(@"请求数据失败：%@",error.localizedDescription);
        }
    }];
//    // 1.1拼接参数(GET方法的请求URL)
//    NSString *urlString = [NSString stringWithFormat:@"%@?access_token=%@", YSPublicTimelineURL ,account.access_token];
//    
//    NSLog(@"public_urlstring:%@",urlString);
//    NSURL *url = [NSURL URLWithString:urlString];
//    
//    // 2.1创建request(默认为GET方式请求数据)
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    // 3.获取URLSession
//    NSURLSession *urlsession = [NSURLSession sharedSession];
//    
//    // 4.利用session创建一个数据加载服务
//    NSURLSessionDataTask *dataTask = [urlsession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//        NSLog(@"-------------%zd",httpResponse.statusCode);
//        
//        if (httpResponse.statusCode == 200) {
//            
//            //JSON解析
//            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];                        NSLog(@"\ndataDict : %@", dataDict);
//            [self.refreshControl endRefreshing];
//            // 调用字典转模型
//            NSArray *objectArray = [self objectWithKeyValues:dataDict];
//            // 将新数据加载在旧数据的后面，新建的数组来实现前插和尾插
//            NSMutableArray *tmpArray = [NSMutableArray array];
//            [tmpArray addObjectsFromArray:self.weiboInfoArray];
//            [tmpArray addObjectsFromArray:objectArray];
//            self.weiboInfoArray = tmpArray;
//            
//            dispatch_sync(dispatch_get_main_queue(), ^{
//                [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
//
//                //                 重新加载table view显示数据
//                [self.tableView reloadData];
//                // 显示最新微博的数量
//                [self showNewWeiboInfoCount:objectArray.count+1];
//            });
//            
//        }else{
//            NSLog(@"请求数据失败：%@",error.localizedDescription);
//        }
//    }];
//    // 恢复数据加载任务
//    [dataTask resume];
    
}


#pragma mark - 下拉操作加载更多数据
/**
 *  配置下拉刷新头
 */
- (void)setupPullToRefresh {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
}
/**
 *  下拉刷新
 */
- (void)pullToRefresh {
    NSLog(@"下拉刷新");
    [self.refreshControl beginRefreshing];
    [self loadMoreWeiboInfoData:YSPublicTimelineURL];
}


/**
 *  加载更多数据
 */
#pragma mark - 加载更多数据YSPublicTimelineURL
- (void)loadMoreWeiboInfoData:(NSString*)WeiboUrl {
    YSAccount *account = [YSAccountTool account];
    
    
    // 1.构造参数字典
    NSDictionary *dict = @{
                           @"access_token" : account.access_token,
                           
                           };
    
    // 2.调用工具发起请求
    [YSNetworkTool GETWithURL:WeiboUrl params:dict completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"-------------%zd",httpResponse.statusCode);
        
        if (httpResponse.statusCode == 200) {
            
            //JSON解析
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];                        NSLog(@"\ndataDict : %@", dataDict);
            [self.refreshControl endRefreshing];
            // 调用字典转模型
            NSArray *objectArray = [self objectWithKeyValues:dataDict];
            // 将新数据加载在旧数据的前面
            NSMutableArray *tmpArray = [NSMutableArray array];
            [tmpArray addObjectsFromArray:objectArray];
            [tmpArray addObjectsFromArray:self.weiboInfoArray];
            self.weiboInfoArray = tmpArray;
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                //                 重新加载table view显示数据
                [self.tableView reloadData];
                // 显示最新微博的数量
                [self showNewWeiboInfoCount:objectArray.count];
            });
            
        }else{
            NSLog(@"请求数据失败：%@",error.localizedDescription);
        }
    }];

//    // 1.1拼接参数(GET方法的请求URL)
//    NSString *urlString = [NSString stringWithFormat:@"%@?access_token=%@", WeiboUrl ,account.access_token];
//    
//    NSLog(@"public_urlstring:%@",urlString);
//    NSURL *url = [NSURL URLWithString:urlString];
//    
//    // 2.1创建request(默认为GET方式请求数据)
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    // 3.获取URLSession
//    NSURLSession *urlsession = [NSURLSession sharedSession];
//    
//    // 4.利用session创建一个数据加载服务
//    NSURLSessionDataTask *dataTask = [urlsession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//        NSLog(@"-------------%zd",httpResponse.statusCode);
//        
//        if (httpResponse.statusCode == 200) {
//            
//            //JSON解析
//            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];                        NSLog(@"\ndataDict : %@", dataDict);
//            [self.refreshControl endRefreshing];
//            // 调用字典转模型
//           NSArray *objectArray = [self objectWithKeyValues:dataDict];
//            // 将新数据加载在旧数据的前面
//            NSMutableArray *tmpArray = [NSMutableArray array];
//            [tmpArray addObjectsFromArray:objectArray];
//            [tmpArray addObjectsFromArray:self.weiboInfoArray];
//            self.weiboInfoArray = tmpArray;
//
//            dispatch_sync(dispatch_get_main_queue(), ^{
////                 重新加载table view显示数据
//                [self.tableView reloadData];
//                // 显示最新微博的数量
//                [self showNewWeiboInfoCount:objectArray.count];
//            });
//            
//        }else{
//            NSLog(@"请求数据失败：%@",error.localizedDescription);
//        }
//    }];
//    // 恢复数据加载任务
//    [dataTask resume];

}



/**
 *  显示最新微博的数量
 *
 *  @param count 最新微博的数量
 */
- (void)showNewWeiboInfoCount:(NSInteger)count {
    // 1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    // btn会显示在self.navigationController.navigationBar的下面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 2.设置图片和文字
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%ld条新的微博",(long) count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"没有新的微博数据" forState:UIControlStateNormal];
    }
    
    // 3.设置按钮的初始frame
    CGFloat btnH = 25;
    CGFloat btnY = self.navigationController.navigationBar.frame.size.height-5;
    
    CGFloat btnX = 100;
    CGFloat btnW = self.view.frame.size.width - 2 * btnX;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    NSLog(@"%lf,btnY:%lf,%lf,%lf",btnX, btnY, btnW, btnH);
    // 4.通过动画移动按钮(按钮向下移动 btnH + 1)
    [UIView animateWithDuration:0.7 animations:^{
        
        btn.transform = CGAffineTransformMakeTranslation(0, btnH);
        
    } completion:^(BOOL finished) { // 向下移动的动画执行完毕后
        
        // 建议:尽量使用animateWithDuration, 不要使用animateKeyframesWithDuration
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 将btn从内存中移除
            [btn removeFromSuperview];
        }];
        
    }];
}
#pragma mark - HWDropdownMenuDelegate
/**
 *  下拉菜单被销毁了
 */
- (void)dropdownMenuDidDismiss:(YSDropDownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = NO;
    // 让箭头向下
    //    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

/**
 *  下拉菜单显示了
 */
- (void)dropdownMenuDidShow:(YSDropDownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;
    // 让箭头向上
    //    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
}



#pragma mark - tableview datasource/delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.weiboInfoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *reusedindentifier = @"YSCell";
    [tableView registerNib:[UINib nibWithNibName:@"YSWeiboInfoTableViewCell" bundle:nil] forCellReuseIdentifier:reusedindentifier];
    YSWeiboInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedindentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"YSWeiboInfoTableViewCell" owner:nil options:nil]lastObject];
    }
    cell.delegate = self;
//    [cell.repostsButton addTarget:self action:@selector(repostsButtonHaveClicked) forControlEvents:UIControlEventTouchUpInside];
    YSWeiboInfo *weiboInfo = self.weiboInfoArray[indexPath.row];
//  另一种方法
//    ///////////////model数组有多少个就减去第几行-1，实现第一行显示最后一个数组，倒序显示
//    YSWeiboInfo *weiboInfo = [self.weiboInfoArray objectAtIndex:(self.weiboInfoArray.count - indexPath.row -1)];
    [cell bindWeiboInfo:weiboInfo];
    
    NSLog(@"row %zd : %@", indexPath.row, weiboInfo);
    if (indexPath.row == self.weiboInfoArray.count -1) {
        self.tableView.tableFooterView.hidden = NO;
    }
    return cell;
}


-(void)repostsButtonHaveClicked{
    NSLog(@"转发转发转发");
}
#pragma mark - reposts comments like delegate
-(void)repostsButtonHaveClicked:(YSWeiboInfoTableViewCell *)cell{
    NSLog(@"-------------------------------");
    // 已模态视图的方式进入下一个页面
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    YSRepostsViewController *repostVC = [storyboard instantiateViewControllerWithIdentifier:@"reposts"];
    repostVC.weiboID = cell.idStr;
    repostVC.weiboName = cell.nameLabel.text;
    repostVC.weiboText= cell.weiboTextLabel.text;
    repostVC.HeadImg = cell.avatarhead;
    [self presentViewController:repostVC animated:YES completion:^{
        
        NSLog(@"推出转发完成");
    }];

}

-(void)commentsButtonHaveClicked:(YSWeiboInfoTableViewCell *)cell{
    // 已模态视图的方式进入下一个页面
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    YSCommentViewController *commentVC = [storyboard instantiateViewControllerWithIdentifier:@"comments"];
    commentVC.weiboID = cell.idStr;
    [self presentViewController:commentVC animated:YES completion:^{
        
        NSLog(@"推出评论完成");
    }];

}
-(void)attitudesButtonHaveClicked:(YSWeiboInfoTableViewCell *)cell{
//    取出赞数
    int count = cell.likeNumber;
    //  还没按下设置为NO
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    myDelegate.isFirstClickLike = YES;
    //    BOOL isSecondClick = NO;
    if (myDelegate.isFirstClickLike) {//第一次按下
        count++;
        NSLog(@"count++count++count++count++count++count++:%d",count);
        [cell.attitudesButton setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
        [cell.attitudesButton setImage:[UIImage imageNamed:@"timeline_icon_like"] forState:UIControlStateNormal];
        myDelegate.isFirstClickLike = NO;
    }
    
//    第二次按下取消
    if(myDelegate.isSecondClickLike){
        if(count>1)
        {   count--;
            [cell.attitudesButton setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
            [cell.attitudesButton setImage:[UIImage imageNamed:@"timeline_icon_unlike"] forState:UIControlStateNormal];
        }else{
            
            [cell.attitudesButton setTitle:@"赞" forState:UIControlStateNormal];
            [cell.attitudesButton setImage:[UIImage imageNamed:@"timeline_icon_unlike"] forState:UIControlStateNormal];
        }
        
        myDelegate.isSecondClickLike = NO;
    }

////  还没按下设置为NO
//    static BOOL isFirstClick = NO;
////    BOOL isSecondClick = NO;
//    if (!isFirstClick) {//还没按第一次
//        count++;
//        NSLog(@"count++count++count++count++count++count++:%d",count);
//         [cell.attitudesButton setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
//        [cell.attitudesButton setImage:[UIImage imageNamed:@"timeline_icon_like"] forState:UIControlStateNormal];
//        isFirstClick = YES;
//    }else if(isFirstClick){
//        if(count>0)
//        {   count--;
//            [cell.attitudesButton setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
//            [cell.attitudesButton setImage:[UIImage imageNamed:@"timeline_icon_unlike"] forState:UIControlStateNormal];
//        }else{
//
//            [cell.attitudesButton setTitle:@"赞" forState:UIControlStateNormal];
//            [cell.attitudesButton setImage:[UIImage imageNamed:@"timeline_icon_unlike"] forState:UIControlStateNormal];
//        }
//        
//        isFirstClick=NO;
//    }else{
//        //            count = 0;
//        [cell.attitudesButton setTitle:@"赞" forState:UIControlStateNormal];
//        [cell.attitudesButton setImage:[UIImage imageNamed:@"timeline_icon_unlike"] forState:UIControlStateNormal];
//    }

    
//    int count = [cell.attitudesButton.titleLabel.text intValue]+1;
//    [cell.attitudesButton setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
//    [cell.attitudesButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateNormal];
}

@end
















