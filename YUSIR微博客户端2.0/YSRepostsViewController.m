//
//  YSRepostsViewController.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/14.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSRepostsViewController.h"
#import "YSAccount.h"
#import "YSCommandHeader.h"
#import "YSAccountTool.h"

#import "YSNetworkTool.h"
@interface YSRepostsViewController ()
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;


@end

@implementation YSRepostsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpRepostsView];
    [self configTextView];
    // Do any additional setup after loading the view.
}

-(void)setUpRepostsView{
    self.repostImageView.image = [UIImage imageNamed:@"avatar_default"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:self.HeadImg];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            self.repostImageView.image = img;
        });
    });
    self.repostNameLabel.text = [NSString stringWithFormat:@"//@%@",self.weiboName];
    self.repostTextLabel.text = [NSString stringWithFormat:@"%@",self.weiboText];
    self.repostTextLabel.textColor = [UIColor blackColor];
    self.repostTextLabel.font = [UIFont systemFontOfSize:12];
    self.repostNameLabel.font = [UIFont systemFontOfSize:18];
    self.repostNameLabel.textColor = [UIColor orangeColor];
}

#pragma mark - toolbar监听键盘
/**
 *  设置text view
 */
- (void)configTextView {
    // 监听键盘的通知
    // 显示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 *  键盘将要显示,toolbar上移
 *
 *  @param notification 系统通知对象
 */
- (void)keyboardWillShow:(NSNotification *)notification {
    // 1.获取keyboard的frame
    CGRect keyboardFrame = [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.获取keyboard的弹出时间
    CGFloat duration = [[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 3.执行上移动画
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardFrame.size.height);
    }];
}

/**
 *  键盘将要隐藏,toolbar下移
 *
 *  @param notification 系统通知对象
 */
- (void)keyboardWillHide:(NSNotification *)notification {
    // 1.获取keyboard的弹出时间
    CGFloat duration = [[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.执行下移动画
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformIdentity;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelBack:(UIBarButtonItem *)sender {
    // 退出该视图控制器
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"退出完成");
    }];

}

/**
 *  转发微博
 */
- (IBAction)doRepostClick:(id)sender {
    if (self.textView.text) {
        NSLog(@"****comment");
        YSAccount *account = [YSAccountTool account];
        
        // 1.构造参数字典
        NSDictionary *dict = @{
                               @"access_token" : account.access_token,
                               @"comment" : self.textView.text,
                               @"id":self.weiboID
                               };
        
        // 2.调用工具发起请求
        [YSNetworkTool POSTWithURL:YSRepostURL params:dict completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            // 数据处理
            if (data) {
                NSDictionary *dataDcit = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"data dict : %@", dataDcit);
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }
        }];

        
//        // 1.URL
//        NSURL *url = [NSURL URLWithString:YSRepostURL];
//        
//        // 2.request
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//        request.HTTPMethod = @"POST";
//        NSString *paramsString = [NSString stringWithFormat:@"access_token=%@&comment=%@&id=%@", account.access_token, self.textView.text, self.weiboID];
//        request.HTTPBody = [NSData dataWithBytes:paramsString.UTF8String length:paramsString.length];
//        
//        // 3.session
//        NSURLSession *seesion = [NSURLSession sharedSession];
//        
//        // 4.data task
//        NSURLSessionDataTask *dataTask = [seesion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"data dict : %@", dataDict);
//            
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }];
//        [dataTask resume];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
