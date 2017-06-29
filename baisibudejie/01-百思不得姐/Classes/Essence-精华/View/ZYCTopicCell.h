//
//  ZYCTopicCell.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/15.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYCTopic;
@interface ZYCTopicCell : UITableViewCell
/** 帖子模型数据 */
@property(nonatomic,strong)ZYCTopic *topic;

+ (instancetype)cell;
@end
