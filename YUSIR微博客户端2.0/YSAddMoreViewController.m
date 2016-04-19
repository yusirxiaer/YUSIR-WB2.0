//
//  YSAddMoreViewController.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/15.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSAddMoreViewController.h"
#import "YSShareViewController.h"
#import "YSPhotoViewController.h"
#import "YSNewsViewController.h"
@interface YSAddMoreViewController ()

@property (weak, nonatomic) IBOutlet UIView *writeView;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIView *newsView;
@property (weak, nonatomic) IBOutlet UIView *registrationView;
@property (weak, nonatomic) IBOutlet UIView *commentsView;
@property (weak, nonatomic) IBOutlet UIView *addMoreView;
@end

@implementation YSAddMoreViewController

- (void)viewDidLoad {
    
//    self.navigationController.navigationBar.hidden = YES;
//    self.tabBarController.tabBar.hidden = YES;

    [super viewDidLoad];
    [self addTapTarget];
//    self.writeView.frame = CGRectMake(0, 0, 100, 110);
    //    [self animationStrat];
    
}
//该动画无法再viewDidLoad中运行，还没加载完成就在内存中执行了，所以需要
//在viewWillAppear中
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self animationStrat];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
//    [self animationStrat];
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self animationDisAppear];
//}
//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
////    [self animationDisAppear];
//}
//开始6弹珠运动
-(void)animationStrat{

//   view(100,110)    70,190,310,   300
    [self setAnimateWithObject:self.writeView Delay:0 Point:CGPointMake(self.writeView.frame.origin.x+50, self.writeView.frame.origin.y-200)];
    [self setAnimateWithObject:self.photoView Delay:0.03 Point:CGPointMake(self.photoView.frame.origin.x+50, self.photoView.frame.origin.y-200)];
    [self setAnimateWithObject:self.newsView Delay:0.05 Point:CGPointMake(self.newsView.frame.origin.x+50, self.newsView.frame.origin.y-200)];
//   view(100,110)    70,190,310,   430
    [self setAnimateWithObject:self.registrationView Delay:0 Point:CGPointMake(self.registrationView.frame.origin.x+50, self.registrationView.frame.origin.y-150)];
    [self setAnimateWithObject:self.commentsView Delay:0.03 Point:CGPointMake(self.commentsView.frame.origin.x+50, self.commentsView.frame.origin.y-150)];
    [self setAnimateWithObject:self.addMoreView Delay:0.05 Point:CGPointMake(self.addMoreView.frame.origin.x+50, self.addMoreView.frame.origin.y-150)];
}

-(void)setAnimateWithObject:(UIView *)view Delay:(NSTimeInterval)delay Point:(CGPoint)point{
    [UIView animateWithDuration:1 delay:delay usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        view.center = point;
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];

}

-(void)animationDisAppear{
    
    //   view(100,110)    70,190,310,   300
    [self setAnimateWithObject:self.writeView Delay:0 Point:CGPointMake(self.writeView.frame.origin.x+50, self.writeView.frame.origin.y+500)];
    [self setAnimateWithObject:self.photoView Delay:0 Point:CGPointMake(self.photoView.frame.origin.x+50, self.photoView.frame.origin.y+500)];
    [self setAnimateWithObject:self.newsView Delay:0 Point:CGPointMake(self.newsView.frame.origin.x+50, self.newsView.frame.origin.y+500)];
    //   view(100,110)    70,190,310,   430
    [self setAnimateWithObject:self.registrationView Delay:0 Point:CGPointMake(self.registrationView.frame.origin.x+50, self.registrationView.frame.origin.y+450)];
    [self setAnimateWithObject:self.commentsView Delay:0 Point:CGPointMake(self.commentsView.frame.origin.x+50, self.commentsView.frame.origin.y+450)];
   
}

- (IBAction)closeAddMoreViewButtonClick:(UIButton *)sender {
    [self  animationDisAppear];
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.addMoreView.center = CGPointMake(310, 800);
    } completion:^(BOOL finished) {
        
        [self dismissViewControllerAnimated:NO completion:nil];

        NSLog(@"退出MORE结束");
    }];

}


-(void)addTapTarget{
    [self addTapWriteView];
    [self addTapPhotoView];
    [self addTapNewsView];
}

//设置三个VIEW的点击事件
-(void)addTapWriteView{
    self.view.userInteractionEnabled = YES;
    //tap手势
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(writeViewEvent)];
//    将手势添加至需要相应的view中
    [self.writeView addGestureRecognizer:tapGesture];
    
}

-(void)writeViewEvent{
    YSShareViewController *sendweiboVC = [[YSShareViewController alloc] initWithNibName:@"YSShareViewController" bundle:[NSBundle mainBundle]];
    [self presentViewController:sendweiboVC animated:YES completion:nil];
}


-(void)addTapPhotoView{
    self.view.userInteractionEnabled = YES;
    //tap手势
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoViewEvent)];
    //    将手势添加至需要相应的view中
    [self.photoView addGestureRecognizer:tapGesture];
    
}
-(void)photoViewEvent{
    YSPhotoViewController *photoVC = [[YSPhotoViewController alloc] initWithNibName:@"YSPhotoViewController" bundle:[NSBundle mainBundle]];
    [self presentViewController:photoVC animated:YES completion:nil];
}



-(void)addTapNewsView{
    self.view.userInteractionEnabled = YES;
    //tap手势
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(newsViewEvent)];
    //    将手势添加至需要相应的view中
    [self.newsView addGestureRecognizer:tapGesture];
}
-(void)newsViewEvent{
    YSNewsViewController *photoVC = [[YSNewsViewController alloc] initWithNibName:@"YSNewsViewController" bundle:[NSBundle mainBundle]];
    
 [self presentViewController:photoVC animated:YES completion:nil];
    
}





@end











