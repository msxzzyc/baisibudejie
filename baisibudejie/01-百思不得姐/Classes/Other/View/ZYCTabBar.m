//
//  ZYCTabBar.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/3/18.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCTabBar.h"
#import "ZYCPublishView.h"

@interface ZYCTabBar()

@property(nonatomic,weak)UIButton *publishButton;

@end

@implementation ZYCTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //设置tabbar背景色
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        //添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.publishButton = publishButton;
        [self addSubview:publishButton];
    }
    return self;
    
}

- (void)publishClick
{
//    ZYCPublishView *publishV = [ZYCPublishView pulishview];
//    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    
//    publishV.frame = window.bounds;
//    
//    [window addSubview:publishV];
    
    
    [ZYCPublishView show];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat width = self.width;
    CGFloat height = self.height;
    
    //设置发布按钮的frame
//    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    
    //设置其他uitabbarbutton的frame

    CGFloat buttonY = 0;
    CGFloat buttonW = width/5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
//        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton ) continue;
        
        //计算按钮x的值
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
       
        //增加索引
        index++;
    }
    
   
}

@end
