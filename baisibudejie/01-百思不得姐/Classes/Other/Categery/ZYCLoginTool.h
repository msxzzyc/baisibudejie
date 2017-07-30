//
//  ZYCLoginTool.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/30.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCLoginTool : NSObject
/**
 *获得当前登录用户的uid，检测是否登录
 *NSString :已经登录 nil：没有登录
 */
+ (void)setUid:(NSString *)uid;
+ (NSString *)getUid;
+ (NSString *)getUid:(BOOL)showRegisterViewController;
@end
