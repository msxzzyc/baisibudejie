//
//  UIView+ZYCExtention.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/3/18.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZYCExtention)
@property(nonatomic,assign)CGSize size;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;

/** 判断一个控件是否真正显示在主窗口范围内 */
- (BOOL)isShowingOnKeyWindow;

+ (instancetype)viewFromXib;
//在分类中声明@property，只会生成方法的声明，不会生成方法的实现和带有_下划线的成员变量
@end
