//
//  UIView+ZYCExtention.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/3/18.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "UIView+ZYCExtention.h"

@implementation UIView (ZYCExtention)

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
    
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
    
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
    
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
    
    
}
- (CGSize)size
{
    return self.frame.size;
    
}

- (CGFloat)width
{
    
    return self.frame.size.width;
}

- (CGFloat)height
{
    
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
    
}

- (CGFloat)y
{
    return self.frame.origin.y;
    
}

- (CGFloat)centerX
{
    
    return self.center.x;
}
- (CGFloat)centerY
{
    
    return self.center.y;
}

- (BOOL)isShowingOnKeyWindow
{
    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    //以主窗口左上角为坐标原点，计算self的矩形框。
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect windowBounds = keyWindow.bounds;
    //主窗口的bounds和self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, windowBounds);
    
    return self.window == keyWindow && !self.isHidden && self.alpha>0.01 && intersects;
    
}
@end
