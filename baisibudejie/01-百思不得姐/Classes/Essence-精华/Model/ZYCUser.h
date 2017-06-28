//
//  ZYCUser.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/28.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCUser : NSObject
/** 用户名 */
@property(nonatomic,copy)NSString *username;
/** 头像 */
@property(nonatomic,copy)NSString *profile_image;
/** sex */
@property(nonatomic,copy)NSString *sex;
@end
