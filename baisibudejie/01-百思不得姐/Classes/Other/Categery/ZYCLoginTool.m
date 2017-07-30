//
//  ZYCLoginTool.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/30.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCLoginTool.h"
#import "ZYCLoginRegisterViewController.h"
@implementation ZYCLoginTool

+(void)setUid:(NSString *)uid
{
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getUid
{
    return [self getUid:NO];
}
+ (NSString *)getUid:(BOOL)showRegisterViewController
{
    NSString *uid = [[NSUserDefaults standardUserDefaults] stringForKey:@"uid"];
    if (showRegisterViewController) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ZYCLoginRegisterViewController *login = [[ZYCLoginRegisterViewController alloc]init];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
        });
        
    }
    return uid;
    
}
@end
