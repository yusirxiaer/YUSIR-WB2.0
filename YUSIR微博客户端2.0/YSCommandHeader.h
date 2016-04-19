//
//  YSCommandHeader.h
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/7.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#ifndef YSCommandHeader_h
#define YSCommandHeader_h

#import "UIView+Extension.h"
// 账号相关
#define YSAppKey @"304321965"
#define YSAppSecret @"2364674587da120460f232e021645616"
#define YSRedirectURI @"https://api.weibo.com/oauth2/default.html"
#define YSLoginURL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", YSAppKey, YSRedirectURI]

// URL相关
#define YSAccessTokenURL @"https://api.weibo.com/oauth2/access_token"
#define YSPublicTimelineURL @"https://api.weibo.com/2/statuses/public_timeline.json"
#define YSFriendsTimelineURL @"https://api.weibo.com/2/statuses/friends_timeline.json"
#define YSHomeTimelineURL @"https://api.weibo.com/2/statuses/home_timeline.json"
// 发送微博
#define YSSendWeiboURL @"https://api.weibo.com/2/statuses/update.json"
// 评论微博
#define YSCommentURL @"https://api.weibo.com/2/comments/create.json"
//自己的微博
#define YSSelfURL @"https://api.weibo.com/2/statuses/user_timeline.json"
//转发微博
#define YSRepostURL @"https://api.weibo.com/2/statuses/repost.json"
//界面相关
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


#endif /* YSCommandHeader_h */
