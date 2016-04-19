//
//  YSAccountTool.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/7.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSAccountTool.h"
#import "YSAccount.h"



#define YSAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]


@implementation YSAccountTool

+ (YSAccount *)account {
    // 取出账号
    YSAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:YSAccountFile];
    
    // 判断账号是否过期
    NSDate *now = [NSDate date];
    if ([now compare:account.expiresTime] == NSOrderedAscending) {
        // 还没过期
        return account;
    } else {
        // 过期
        return nil;
    }
}

+ (void)saveAccount:(YSAccount *)account {
    // 计算过期时间
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    
    [NSKeyedArchiver archiveRootObject:account toFile:YSAccountFile];
}




@end
