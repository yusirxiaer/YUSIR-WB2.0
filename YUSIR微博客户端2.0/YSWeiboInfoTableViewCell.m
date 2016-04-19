//
//  YSWeiboInfoTableViewCell.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/8.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSWeiboInfoTableViewCell.h"
#import "AppDelegate.h"
@implementation YSWeiboInfoTableViewCell

/**
 *  绑定数据
 *
 *  @param weiboInfo
 */
- (void)bindWeiboInfo:(YSWeiboInfo *)weiboInfo {
    
    self.idStr= weiboInfo.idstr;
    self.avatarhead = weiboInfo.avatar_large;
    self.likeNumber = weiboInfo.attitudes_count;
    self.profileImgView.layer.cornerRadius =30;
    self.profileImgView.image = [UIImage imageNamed:@"avatar_default"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:weiboInfo.avatar_large];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            self.profileImgView.image = img;
        });
        
    });
    NSLog(@"weiboInfo.name=%@",weiboInfo.name);
    self.nameLabel.text = weiboInfo.name;
    self.sourceLabel.text = weiboInfo.source ;
    self.createdAtLabel.text = weiboInfo.created_at;
    self.weiboTextLabel.text = weiboInfo.text;
    [self setupBtn:self.repostsButton originalTitle:@"转发" count:weiboInfo.reposts_count];
    [self setupBtn:self.commentsButton originalTitle:@"评论" count:weiboInfo.comments_count];
    
    [self setupBtn:self.attitudesButton originalTitle:@"赞" count:weiboInfo.attitudes_count];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if(!myDelegate.isFirstClickLike){
        [self.attitudesButton setImage:[UIImage imageNamed:@"timeline_icon_unlike"] forState:UIControlStateNormal];
    }

    
}


/**
 *  设置按钮的显示标题
 *
 *  @param btn           哪个按钮需要设置标题
 *  @param originalTitle 按钮的原始标题(显示的数字为0的时候, 显示这个原始标题)
 *  @param count         显示的个数
 */
- (void)setupBtn:(UIButton *)btn originalTitle:(NSString *)originalTitle count:(int)count
{
    /**
     0 -> @"转发"
     <10000  -> 完整的数量, 比如个数为6545,  显示出来就是6545
     >= 10000
     * 整万(10100, 20326, 30000 ....) : 1万, 2万
     * 其他(14364) : 1.4万
     */
        if (count) { // 个数不为0
        NSString *title = nil;
        if (count < 10000) { // 小于1W
            title = [NSString stringWithFormat:@"%d", count];
        } else { // >= 1W
            // 42342 / 1000 * 0.1 = 42 * 0.1 = 4.2
            // 10742 / 1000 * 0.1 = 10 * 0.1 = 1.0
            // double countDouble = count / 1000 * 0.1;
            
            // 42342 / 10000.0 = 4.2342
            // 10742 / 10000.0 = 1.0742
            double countDouble = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", countDouble];
            
            // title == 4.2万 4.0万 1.0万 1.1万
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:originalTitle forState:UIControlStateNormal];
    }
    
}

//触发代理方法
- (IBAction)repostsButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(repostsButtonHaveClicked:)]) {
        [self.delegate repostsButtonHaveClicked:self];
    }
}
- (IBAction)commentsButtonClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(commentsButtonHaveClicked:)]) {
        [self.delegate commentsButtonHaveClicked:self];
        
    }
}
- (IBAction)attitudesButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(attitudesButtonHaveClicked:)]) {
        [self.delegate attitudesButtonHaveClicked:self];
        static int num = 0;
        num++;
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];

        if (num%2!=0) {//奇数次按下
            myDelegate.isFirstClickLike = YES;
        }else if(num >0){
            myDelegate.isSecondClickLike = YES;
        }
        
        
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
//    格式化日期 Thu Mar 10 10:16:36 +0800 2016
//NSDate *now = [NSDate date];
//NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//formatter.dateFormat = @"E MM dd HH:mm:ss +0000 yyyy";
//NSDate *created_at = [formatter dateFromString:weiboInfo.created_at];
//NSTimeInterval timeInterval = [now timeIntervalSinceDate:created_at];
//NSLog(@"---------timeInterval:%zd",(int)timeInterval);
//int time = (int)timeInterval/60;
//if (time <1) {
//    self.createdAtLabel.text = @"刚刚";
//}else if (time<10){
//    self.createdAtLabel.text = @"最近";
//    
//}else if (time<60){
//    self.createdAtLabel.text = [NSString stringWithFormat:@"%d分钟前",time];
//    
//}else if(time<24*60){
//    self.createdAtLabel.text = [NSString stringWithFormat:@"%d小时前",time/60];
//}else{
//    formatter.dateFormat = @"yyyy-MM-dd ss:mm:ss";
//    NSString *dateStr = [formatter stringFromDate:created_at];
//    self.createdAtLabel.text = dateStr;
//}
//
