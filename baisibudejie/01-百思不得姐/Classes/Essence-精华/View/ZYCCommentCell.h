//
//  ZYCCommentCell.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/30.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYCComment;
@interface ZYCCommentCell : UITableViewCell
/** 帖子模型数据 */
@property(nonatomic,strong)ZYCComment *comment;
+(instancetype)commentCell;

@end
