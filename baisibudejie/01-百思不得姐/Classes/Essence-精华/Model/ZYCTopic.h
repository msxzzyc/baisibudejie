//
//  ZYCTopic.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/12.
//  Copyright © 2017年 wpzyc. All rights reserved.
// 帖子（段子）

#import <UIKit/UIKit.h>//有CGFloat类型的属性必须使用该框架
@class ZYCComment;
@interface ZYCTopic : NSObject
/** 用户id */
@property(nonatomic,copy)NSString *ID;
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
/** 大图的url*/
@property(nonatomic,copy)NSString *largeImage;
/** 中图的url*/
@property(nonatomic,copy)NSString *middleImage;
/** 小图的url*/
@property(nonatomic,copy)NSString *smallImage;

/** 图片的宽度 */
@property(nonatomic,assign)CGFloat width;
/** 图片的高度 */
@property(nonatomic,assign)CGFloat height;
/** 帖子的类型 */
@property(nonatomic,assign)ZYCTopicType type;
/** 音频时长 */
@property(nonatomic,assign)NSInteger voicetime;
/** 音频播放次数 */
@property(nonatomic,assign)int playcount;

/** 视频时长 */
@property(nonatomic,assign)NSInteger videotime;


/** 是否gif图片 */
@property(nonatomic,assign)BOOL is_gif;

/** 最热评论 */
@property(nonatomic,strong)ZYCComment *top_cmt;


/********* 额外的辅助属性 ************/
@property(nonatomic,assign,readonly)CGFloat cellHeight;
/** 图片控件的frame */
@property(nonatomic,assign,readonly)CGRect pictureViewFrame;
/** 图片是否太大 */
@property(nonatomic,assign,getter=isBigPicture)BOOL isBigPicture;
/** 图片下载进度 */
@property(nonatomic,assign)CGFloat pictureProgress;

/** 声音控件的frame */
@property(nonatomic,assign,readonly)CGRect voiceViewFrame;

/** 视频控件的frame */
@property(nonatomic,assign,readonly)CGRect videoViewFrame;

@end

