//
//  ZYCCommentViewController.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/29.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYCTopic;
@class ZYCComment;
@class ZYCUser;
@interface ZYCCommentViewController : UIViewController
/** 帖子模型数据 */
@property(nonatomic,strong)ZYCTopic *topic;
@end
