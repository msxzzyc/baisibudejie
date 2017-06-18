//
//  ZYCTopic.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/12.
//  Copyright © 2017年 wpzyc. All rights reserved.
// 帖子（段子）

#import <UIKit/UIKit.h>//有CGFloat类型的属性必须使用该框架

@interface ZYCTopic : NSObject
/** 用户名 */
@property(nonatomic,copy)NSString *name;
/** 段子内容 */
@property(nonatomic,copy)NSString *text;
/** 头像 */
@property(nonatomic,copy)NSString *profile_image;
/** 发帖时间 */
@property(nonatomic,copy)NSString *create_time;
/** 顶的数量 */
@property(nonatomic,assign)NSInteger ding;
/** 踩的数量 */
@property(nonatomic,assign)NSInteger cai;
/** 转发数量 */
@property(nonatomic,assign)NSInteger repost;
/** 评论数量 */
@property(nonatomic,assign)NSInteger comment;
/** 上一页时间 */
@property(nonatomic,copy)NSString *maxtime;
/** 是否为新浪加v用户*/
@property(nonatomic,assign,getter = isVip)BOOL is_vip;


/********* 额外的辅助属性 ************/
@property(nonatomic,assign,readonly)CGFloat cellHeight;

@end

