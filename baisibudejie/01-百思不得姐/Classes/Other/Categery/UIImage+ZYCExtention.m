//
//  UIImage+ZYCExtention.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/4.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "UIImage+ZYCExtention.h"

@implementation UIImage (ZYCExtention)
- (UIImage *)circleImage
{
    //1.开启上下文 yes代表不透明,no代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    //2.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //3.添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    //4.裁剪
    CGContextClip(ctx);
    //5.将图片画上去
    [self drawInRect:rect];
    //6.获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //7.关闭上下文
    UIGraphicsEndImageContext();
    return image;
}
@end
