//
//  UIBarButtonItem+ZYCExtention.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/3/19.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZYCExtention)


+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
