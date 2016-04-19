//
//  YSRepostsViewController.h
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/14.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSRepostsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *repostImageView;
@property (weak, nonatomic) IBOutlet UILabel *repostNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *repostTextLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendBarbuttonItem;

// 待评论的微博ID
@property (copy, nonatomic) NSString *weiboID;

@property (copy, nonatomic) NSString *weiboName;
@property (copy, nonatomic) NSString *weiboText;
@property (copy, nonatomic) NSString *HeadImg;
@end
