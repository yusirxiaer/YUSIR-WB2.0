//
//  YSNetworkTool.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/16.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSNetworkTool.h"

@implementation YSNetworkTool



+ (void)GETWithURL:(NSString *)urlString
            params:(NSDictionary *)dict
 completionHandler:(void (^)(NSData * data, NSURLResponse *response, NSError * error))completionHandler {
    // 构造url string
    NSMutableString *paramsStr = [NSMutableString string];
    NSArray *keyArray = [dict allKeys];
    for (int i = 0; i < keyArray.count; i++) {
        NSString *key = keyArray[i];
        NSString *value = dict[key];
        
        // 拼接
        NSString *tmp;
        if (i == 0) {
            tmp = [NSString stringWithFormat:@"%@=%@", key, value];
        } else {
            tmp = [NSString stringWithFormat:@"&%@=%@", key, value];
        }
        [paramsStr appendString:tmp];
    }
    urlString = [NSString stringWithFormat:@"%@?%@", urlString, paramsStr];
    // 格式化字符串，格式化其中不符合格式要求的字符
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 1.URL
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3.session
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 4.data task
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:completionHandler];
    [dataTask resume];
}

+ (void)POSTWithURL:(NSString *)urlString
             params:(NSDictionary *)dict
  completionHandler:(void (^)(NSData * data, NSURLResponse *response, NSError * error))completionHandler {
    // 构造url string
    NSMutableString *paramsString = [NSMutableString string];
    NSArray *keyArray = [dict allKeys];
    for (int i = 0; i < keyArray.count; i++) {
        NSString *key = keyArray[i];
        NSString *value = dict[key];
        NSString *tmp;
        if (i == 0) {
            tmp = [NSString stringWithFormat:@"%@=%@", key, value];
        } else {
            tmp = [NSString stringWithFormat:@"&%@=%@", key, value];
        }
        [paramsString appendString:tmp];
    }
    
    // 1.URL
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *dataString = [paramsString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    request.HTTPBody = [NSData dataWithBytes:dataString.UTF8String length:dataString.length];
    
    // 3.session
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 4.data task
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:completionHandler];
    [dataTask resume];
}


@end
