//
//  YSDiscoveryViewController.h
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/9.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSDiscoveryViewController : UITableViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong,nonatomic) NSTimer *timer;
@end
