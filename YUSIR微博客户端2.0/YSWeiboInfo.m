//
//  YSWeiboInfo.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/8.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSWeiboInfo.h"
#import "NSDate+SQ.h"
@implementation YSWeiboInfo


// 格式化createAt字符串
- (NSString *)created_at {
    // _createAt == Thu Jan 28 09:40:03 +0800 2016
    //    NSLog(@"creteAt : %@", _createAt);
    // 1.获得微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //#warning 真机调试下, 必须加上这段
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *createdDate = [fmt dateFromString:_created_at];
    
    // 2..判断微博发送时间和现在时间的差距
    if (createdDate.isToday) { // 今天
        if (createdDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%zd小时前", createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%zd分钟前", createdDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (createdDate.isYesterday) { // 昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if (createdDate.isThisYear) { // 今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
    
}

// 格式化source字符串
- (void)setSource:(NSString *)source
{
    if (source.length > 0) {
        int loc =(int) [source rangeOfString:@">"].location + 1;
        int length = (int)[source rangeOfString:@"</"].location - loc;
        NSRange range = NSMakeRange(loc, length);
        source = [source substringWithRange:range];
        
        _source = [NSString stringWithFormat:@"来自%@", source];
    } else {
        _source = source;
    }
}


- (NSString *)description {
    return [NSString stringWithFormat:@"\nID : %@,\nname : %@, \navatar_large : %@, \ncreateAt : %@, \nweiboText : %@\nreposts_count:%d\n,comments_count:%d\nattitudes_count:%d\n}",self.idstr, self.name, self.avatar_large, self.created_at, self.text,self.reposts_count,self.comments_count,self.attitudes_count];
}


@end
