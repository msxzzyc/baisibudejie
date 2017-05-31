//
//  UIBarButtonItem+ZYCExtention.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/3/19.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "UIBarButtonItem+ZYCExtention.h"

@implementation UIBarButtonItem (ZYCExtention)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc]initWithCustomView:button];
    
}

@end
