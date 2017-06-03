//
//  ZYCRecommendUser.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/2.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCRecommendUser : NSObject

/** 头像 */
@property(nonatomic,copy)NSString *header;
/** 粉丝数（关注该用户的人数）*/
@property(nonatomic,assign)NSInteger fans_count;
/** 昵称 */
@property(nonatomic,copy)NSString *screen_name;





@end
