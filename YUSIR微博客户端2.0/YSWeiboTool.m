//
//  YSWeiboTool.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/11.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSWeiboTool.h"
#import <UIKit/UIKit.h>
#import "YSTabBarViewController.h"
#import "YSNewfeatureViewController.h"
@implementation YSWeiboTool

+ (void)choseRootViewController {
    //    static NSString *key = @"BundleVersion";
    //    // 取出沙盒中存储的上次使用软件的版本号
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSString *lastVersion = [defaults stringForKey:key];
    //
    //    // 获得当前软件的版本号
    //    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //    if ([currentVersion isEqualToString:lastVersion]) {
    //        // 跳转到首页
    //
    //    } else {
    //        // 新版本，跳转到新特性界面
    //
    //        // 存储新版本
    //        [defaults setObject:currentVersion forKey:key];
    //        [defaults synchronize];
    //    }
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[YSNewfeatureViewController alloc] init];
    
}

@end
