//
//  YSCommentViewController.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/14.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSCommentViewController.h"
#import "YSAccount.h"
#import "YSCommandHeader.h"
#import "YSAccountTool.h"
#import "YSNetworkTool.h"
@interface YSCommentViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation YSCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doCancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


/**
 *  发表评论
 */
- (IBAction)doCommentClick:(id)sender {
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
        [YSNetworkTool POSTWithURL:YSCommentURL params:dict completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
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
//        NSURL *url = [NSURL URLWithString:YSCommentURL];
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



@end










