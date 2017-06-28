//
//  ZYCTopicVideoView.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/28.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYCTopic;
@interface ZYCTopicVideoView : UIView
/** 帖子模型数据 */
@property(nonatomic,strong)ZYCTopic *topic;
+ (instancetype)videoView;
@end
