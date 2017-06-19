//
//  ZYCTopicPictureView.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/19.
//  Copyright © 2017年 wpzyc. All rights reserved.
// 图片中间的内容

#import <UIKit/UIKit.h>
@class ZYCTopic;
@interface ZYCTopicPictureView : UIView
/** 帖子模型数据 */
@property(nonatomic,strong)ZYCTopic *topic;
+ (instancetype)pictureView;

@end
