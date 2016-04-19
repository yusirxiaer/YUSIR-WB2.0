//
//  YSAccount.h
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/7.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  账号模型
 */
@interface YSAccount : NSObject<NSCoding>

/**
 *  访问令牌
 */
@property (copy, nonatomic) NSString *access_token;

/**
 *  账号过期时间
 */
@property (strong, nonatomic) NSDate *expiresTime;
//当前授权用户的UID。
@property (assign, nonatomic) long long uid;
//access_token的生命周期（该参数即将废弃，开发者请使用expires_in)
@property (assign, nonatomic) long long remind_in;
//access_token的生命周期，单位是秒数。
@property (assign, nonatomic) long long expires_in;

/**
 *  用户昵称
 */
@property (copy, nonatomic) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;



@end
