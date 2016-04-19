//
//  YSAccountTool.h
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/7.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YSAccount;

/**
 *  账号管理工具类
 */
@interface YSAccountTool : NSObject

/**
 *  返回存储的账号信息
 *
 *  @return 账号信息
 */
+ (YSAccount *)account;

/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */
+ (void)saveAccount:(YSAccount *)account;
@end
