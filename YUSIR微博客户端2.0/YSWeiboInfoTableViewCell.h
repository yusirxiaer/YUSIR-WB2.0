//
//  YSWeiboInfoTableViewCell.h
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/8.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSWeiboInfo.h"
@class YSWeiboInfoTableViewCell;
@protocol YSWeiboInfoTableViewCellDelegate <NSObject>
@optional
-(void)repostsButtonHaveClicked:(YSWeiboInfoTableViewCell *)cell;
-(void)commentsButtonHaveClicked:(YSWeiboInfoTableViewCell *)cell;
-(void)attitudesButtonHaveClicked:(YSWeiboInfoTableViewCell *)cell;

@end

@interface YSWeiboInfoTableViewCell : UITableViewCell

@property (nonatomic,weak) id<YSWeiboInfoTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;

@property (weak, nonatomic) IBOutlet UILabel *weiboTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *repostsButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;
@property (weak, nonatomic) IBOutlet UIButton *attitudesButton;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;

//属性传值传id
@property (assign,nonatomic)int likeNumber;
@property (copy,nonatomic)NSString *idStr;
@property (copy,nonatomic)NSString *avatarhead;//头像属性为repost传值
@property (strong, nonatomic) YSWeiboInfo *bindData;
- (void)bindWeiboInfo:(YSWeiboInfo *)weiboInfo;
@end
