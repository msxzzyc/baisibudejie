//
//  ZYCTopicVoiceView.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/27.
//  Copyright © 2017年 wpzyc. All rights reserved.
// 声音帖子中间的内容

#import <UIKit/UIKit.h>
@class ZYCTopic;
@interface ZYCTopicVoiceView : UIView
/** 帖子模型数据 */
@property(nonatomic,strong)ZYCTopic *topic;
+ (instancetype)voiceView;
@end
