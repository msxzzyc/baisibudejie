
//
//  ZYCPushGuideView.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/9.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCPushGuideView.h"

@implementation ZYCPushGuideView


- (IBAction)close {
    ZYCLogFunc;
    [self removeFromSuperview];
}

+ (instancetype)guideView
{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass (self) owner:nil options:nil] lastObject];
}

+ (void)show
{
    //    ZYCLog(@"%@",[NSBundle mainBundle].infoDictionary);
    
    NSString *key = @"CFBundleShortVersionString";
    
    //获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (currentVersion != sanboxVersion) {
        ZYCPushGuideView *guideView = [ZYCPushGuideView guideView];
        
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        //立即存储
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
