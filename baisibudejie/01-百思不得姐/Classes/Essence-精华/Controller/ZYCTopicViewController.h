//
//  ZYCTopicViewController.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/17.
//  Copyright © 2017年 wpzyc. All rights reserved.
// 最基本的帖子控制器

#import <UIKit/UIKit.h>

typedef enum{
    ZYCTopicTypeAll = 1,
    ZYCTopicTypeVideo = 41,
    ZYCTopicTypeVoice = 31,
    ZYCTopicTypePicture = 10,
    ZYCTopicTypeWord = 29
}ZYCTopicType;

@interface ZYCTopicViewController : UITableViewController
/** 帖子类型 */
@property(nonatomic,assign)NSInteger type;

@end
