//
//  ZYCComment.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/28.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZYCUser;
@interface ZYCComment : NSObject
/** 评论的音频时长 */
@property(nonatomic,assign)NSInteger voicetime;
/** 评论的文字内容 */
@property(nonatomic,copy)NSString *content;
/** 评论被赞数 */
@property(nonatomic,assign)NSInteger like_count;
/** 用户 */
@property(nonatomic,strong)ZYCUser *user;

@end
