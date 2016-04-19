//
//  YSOAuth2ViewController.h
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/7.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSOAuth2ViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end
