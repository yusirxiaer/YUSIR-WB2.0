//
//  YSShareViewController.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/11.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSShareViewController.h"
#import "YSAccount.h"
#import "YSCommandHeader.h"
#import "YSAccountTool.h"
#import "YSNetworkTool.h"
#import "LBProgressHUD.h"
@interface YSShareViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@end

@implementation YSShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configTextView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/**
 *  取消
 */
- (IBAction)doCancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Send Weibo
/**
 *  发送微博
 */
- (IBAction)doSendClick:(id)sender {
    if (self.textView.text) {
        [LBProgressHUD showHUDto:self.view animated:YES];
        YSAccount *account = [YSAccountTool account];
        // 1.构造参数字典
        NSDictionary *dict = @{
                               @"access_token" : account.access_token,
                               @"status" : self.textView.text
                               };
        
        // 2.调用工具发起请求
        [YSNetworkTool POSTWithURL:YSSendWeiboURL params:dict completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            // 数据处理
            if (data) {
                NSDictionary *dataDcit = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"data dict : %@", dataDcit);
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }
        }];
//          原来的方法
//        // 1.构造URL
//        NSURL *url = [NSURL URLWithString:YSSendWeiboURL];
//        
//        // 2.构造request
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//        request.HTTPMethod = @"POST";
//        NSString *dataString = [NSString stringWithFormat:@"access_token=%@&status=%@", account.access_token, self.textView.text];
//        NSData *params = [NSData dataWithBytes:dataString.UTF8String length:dataString.length];
//        request.HTTPBody = params;
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



@end










