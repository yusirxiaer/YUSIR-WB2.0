//
//  YSWeiboInfo.h
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/8.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSWeiboInfo : NSObject

//微博（status）返回字段
//created_at	string	微博创建时间
@property (copy,nonatomic)NSString *created_at;
//text	string	微博信息内容
@property (copy,nonatomic)NSString *text;
//source	string	微博来源
@property (copy,nonatomic)NSString *source;
//idstr	string	字符串型的微博ID
@property (copy,nonatomic)NSString *idstr;
//reposts_count	int	转发数
@property (assign,nonatomic) int reposts_count;
//comments_count	int	评论数
@property (assign,nonatomic) int comments_count;
//attitudes_count	int	表态数
@property (assign,nonatomic) int attitudes_count;
//users返回字段
@property (copy,nonatomic)NSString *name;
@property (copy,nonatomic)NSString *profile_image_url;
@property (copy,nonatomic)NSString *avatar_large;



@end
