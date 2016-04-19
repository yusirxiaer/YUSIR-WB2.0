//
//  YSSearchBar.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/17.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSSearchBar.h"
#import "YSCommandHeader.h"
@implementation YSSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        //    拉伸小图片变成条，不要头尾只拉伸中间
        self.background = [[UIImage imageNamed:@"searchbar_textfield_background"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 3, 0, 3)];      // 通过init来创建初始化绝大部分控件，控件都是没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}

@end
