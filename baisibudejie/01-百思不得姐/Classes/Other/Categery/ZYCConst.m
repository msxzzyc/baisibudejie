//
//  ZYCConst.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/15.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "UIKit/UIKit.h"


/** 精华-顶部标题的Y */
CGFloat const ZYCTitlesViewY = 64;
/** 精华-顶部标题的高度 */
CGFloat const ZYCTitlesViewH = 35;

/** 精华-cell-间距 */
CGFloat const ZYCTopicCellMargin = 10;
/** 精华-cell-文字内容的Y */
CGFloat const ZYCTopicCellTextY = 55;
/** 精华-cell-底部工具条的高度 */
CGFloat const ZYCTopicCellBottomBarH = 35;
/** 精华-cell-图片帖子的最大高度 */
CGFloat const ZYCTopicPictureMaxH = 1000;
/** 精华-cell-图片帖子一旦超过最大高度，就使用Break高度 */
CGFloat const ZYCTopicPictureBreakH = 250;


/** ZYCUser模型-性别属性值 */
NSString * const ZYCUserSexMale = @"m";
/** ZYCUser模型-性别属性值 */
NSString * const ZYCUserSexFemale = @"f";

/** 精华-cell-最热评论标题的最大高度 */
CGFloat const ZYCTopicCellTopCmtTitleH = 20;

/** tabBar被选中的通知名字 */
NSString * const ZYCDidSelectNotification = @"ZYCDidSelectNotification";
/** tabBar被选中的通知 - 被选中的控制器的 index key */
NSString * const ZYCSelectedControllerIndexKey = @"ZYCSelectedControllerIndexKey";
/** tabBar被选中的通知 - 被选中的控制器  key */
NSString * const ZYCSelectedControllerKey = @"ZYCSelectedControllerKey";

/** 标签-间距 */
CGFloat const ZYCTagMargin = 5;
