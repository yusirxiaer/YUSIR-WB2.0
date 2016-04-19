//
//  YSNetworkTool.h
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/16.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSNetworkTool : NSObject



// GET
+ (void)GETWithURL:(NSString *)urlString
            params:(NSDictionary *)dict
 completionHandler:(void (^)(NSData * data, NSURLResponse *response, NSError * error))completionHandler;

// POST
+ (void)POSTWithURL:(NSString *)urlString
             params:(NSDictionary *)dict
  completionHandler:(void (^)(NSData * data, NSURLResponse *response, NSError * error))completionHandler;


@end
