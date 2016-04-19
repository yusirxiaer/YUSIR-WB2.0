//
//  YSAccount.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/7.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSAccount.h"

@implementation YSAccount
+ (instancetype)accountWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

/**
 *  从文件中解析对象的时候调用
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expiresTime = [aDecoder decodeObjectForKey:@"expiresTime"];
        self.uid = [aDecoder decodeInt64ForKey:@"uid"];
        self.remind_in = [aDecoder decodeInt64ForKey:@"remind_in"];
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expiresTime forKey:@"expiresTime"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.name forKey:@"name"];
}


@end
