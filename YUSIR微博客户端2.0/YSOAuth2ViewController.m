//
//  YSOAuth2ViewController.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/7.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSOAuth2ViewController.h"
#import "YSCommandHeader.h"
#import "YSAccount.h"
#import "YSAccountTool.h"
#import "YSWeiboTool.h"

#import "YSHomeViewController.h"

#import "LBProgressHUD.h"
@interface YSOAuth2ViewController ()

@property (nonatomic,strong) UIImageView *image;
@end

@implementation YSOAuth2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.image.image = [UIImage imageNamed:@"KAIJI"];
    [self.view addSubview:self.image];
    //    加载授权页面
    NSURL *url = [NSURL URLWithString:YSLoginURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - web view  delegate
/**
 *  web view开始发送请求时调用
 *
 *  @param webView <#webView description#>
 */
-(void)webViewDidStartLoad:(UIWebView *)webView{
//     [self.activityIndicator startAnimating];
    [LBProgressHUD showHUDto:self.view animated:YES];
}

/**
 *  web view请求完毕时调用
 *
 *  @param webView <#webView description#>
 */
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self.image removeFromSuperview];

//    [self.activityIndicator stopAnimating];
}

/**
 *  web view请求失败时调用
 *
 *  @param webView <#webView description#>
 *  @param error   <#error description#>
 */
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [LBProgressHUD hideAllHUDsForView:self.view animated:YES];

//    [self.activityIndicator stopAnimating];
    NSLog(@"error:%@",error.localizedDescription);
}

/**
 *  当web view发送一个请求前，都会调用该方法，询问代理是否可以加载这个页面（请求）
 *
 *  @param webView        <#webView description#>
 *  @param request        <#request description#>
 *  @param navigationType <#navigationType description#>
 *
 *  @return YES:可以  NO：不可以
 */
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStringOrig = request.URL.absoluteString;
    NSLog(@"urlStringOrig =%@",urlStringOrig);
    
    // 2.查找code=在urlString中的位置
    NSRange range = [urlStringOrig rangeOfString:@"code="];
    
    // 3.如果urlString包含code=
    if (range.length) {
        // 4.截取code=后面的请求标记（经过用户授权成功的）
        int loc = (int)(range.location + range.length);
        NSString *code = [urlStringOrig substringFromIndex:loc];
        NSLog(@"code :%@",code);
        // 5.想新浪的认证服务器发送请求，使用code换取一个access token
        [self accessTokenWithCode:code];
        
        // 不加载这个请求
        return NO;
    }
    
    
    return YES;
}
#pragma mark - 通过code换取一个access token
/**
 *  通过code换取一个access token
 *
 *  @param code
 */
- (void)accessTokenWithCode:(NSString *)code {
    // 1.封装请求参数
    //    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    params[@"client_id"] = YSAppKey;
    //    params[@"client_secret"] = YSAppSecret;
    //    params[@"grant_type"] = @"authorization_code";
    //    params[@"code"] = code;
    //    params[@"redirect_uri"] = YSRedirectURI;
    
    // 格式化为字符串
    NSString *httpBodyStr = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@", YSAppKey, YSAppSecret, code, YSRedirectURI];
    
    // 2.发送请求
    NSURL *url = [NSURL URLWithString:YSAccessTokenURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [NSData dataWithBytes:httpBodyStr.UTF8String length:httpBodyStr.length];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//         3.将JSON数据转换为账号模型
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
             NSLog(@"dict:%@",dict);
        //存access_taken
//        NSString *str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"access_token"]];
//        NSLog(@"这里错了，之前属性传值传的是code,应该把access_taken传到YSHome中去，从dict字典中把他取出来");
//        homeVC.codeString = str;
//        NSLog(@"code:%@",homeVC.codeString);
//----------------------------------------------------
        YSAccount *account = [YSAccount accountWithDict:dict];
        // 4.将账号存储在文件
        [YSAccountTool saveAccount:account];
        // 5.跳转到根视图控制器
        [YSWeiboTool choseRootViewController];
        NSLog(@"****************************************");
    }];
    [dataTask resume];
    [LBProgressHUD showHUDto:self.view animated:YES];

}



@end
