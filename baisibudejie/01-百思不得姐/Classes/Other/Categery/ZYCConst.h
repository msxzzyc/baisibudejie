//
//  ZYCConst.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/15.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "UIKit/UIKit.h"
typedef enum{
    ZYCTopicTypeAll = 1,
    ZYCTopicTypeVideo = 41,
    ZYCTopicTypeVoice = 31,
    ZYCTopicTypePicture = 10,
    ZYCTopicTypeWord = 29
}ZYCTopicType;

/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const ZYCTitlesViewY;
/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const ZYCTitlesViewH;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const ZYCTopicCellMargin;
/** 精华-cell-文字内容的Y */
UIKIT_EXTERN CGFloat const ZYCTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const ZYCTopicCellBottomBarH;
/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const ZYCTopicPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度，就使用Break高度 */
UIKIT_EXTERN CGFloat const ZYCTopicPictureBreakH;


/** ZYCUser模型-性别属性值 */
UIKIT_EXTERN NSString * const ZYCUserSexMale;
/** ZYCUser模型-性别属性值 */
UIKIT_EXTERN NSString * const ZYCUserSexFemale;

/** 精华-cell-最热评论标题的最大高度 */
UIKIT_EXTERN CGFloat const ZYCTopicCellTopCmtTitleH;
