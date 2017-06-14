//
//  ZYCTopicViewCell.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/12.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYCTopic.h"
@interface ZYCTopicViewCell : UITableViewCell
/** 帖子模型数据 */
@property(nonatomic,strong)ZYCTopic *topic;
@end
