//
//  ZYCTopWindow.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/2.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCTopWindow.h"

@implementation ZYCTopWindow
static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc]init];
    window_.windowLevel = UIWindowLevelAlert;
    window_.backgroundColor = [UIColor clearColor];
    window_.frame = CGRectMake(0, 0, ZYCScreenW, 20);
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(windowClick)]];
    
}
+ (void)show
{
    
    window_.hidden = NO;
}
+ (void)hide
{
    window_.hidden = YES;
    
}

/**
 *监听窗口点击
 */
+ (void)windowClick
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [self searchScrollViewInView:window];
    
}

+ (void)searchScrollViewInView:(UIView *)superview
{
   
    //如果是scrollView，滚到最顶部（递归）
    for (UIScrollView *subview in superview.subviews) {
        
//        //得到subview在窗口中的frame（转换坐标系）
//        CGRect newFrame = [subview.superview convertRect:subview.frame toView:nil];//nil默认为主窗口
////        CGRect newFrame = [[UIApplication sharedApplication].keyWindow convertRect:subview.frame fromView:subview.superview];
//        
//        CGRect windowBounds = [UIApplication sharedApplication].keyWindow.bounds;
//        //判断一个控件是否真正显示在主窗口范围内
//        BOOL isShowingOnWindow = subview.window == [UIApplication sharedApplication].keyWindow && !subview.isHidden&&subview.alpha>0.01 && CGRectIntersectsRect(newFrame, windowBounds);
        
        
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            ZYCLogFunc;
            CGPoint offset = subview.contentOffset;
            offset.y = -subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        //继续查找子控件
        [self searchScrollViewInView:subview];
    }
}
@end
