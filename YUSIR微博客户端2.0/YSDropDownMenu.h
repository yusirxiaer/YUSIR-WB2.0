//
//  YSDropDownMenu.h
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/17.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YSDropDownMenu;


@protocol YSDropDownMenuDelegate <NSObject>
@optional
- (void)dropdownMenuDidDismiss:(YSDropDownMenu *)menu;
- (void)dropdownMenuDidShow:(YSDropDownMenu *)menu;
@end

@interface YSDropDownMenu : UIView
@property (nonatomic, weak) id<YSDropDownMenuDelegate> delegate;

+ (instancetype)menu;

/**
 *  显示
 */
- (void)showFrom:(UIView *)from OffsetX:(int)num OffsetY:(int)numY;
/**
 *  销毁
 */
- (void)dismiss;

/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;
@end
