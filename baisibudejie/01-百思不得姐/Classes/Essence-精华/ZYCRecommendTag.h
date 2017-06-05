//
//  ZYCRecommendTag.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/5.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCRecommendTag : NSObject
/** 头像 */
@property(nonatomic,copy)NSString *image_list;
/** 标签名 */
@property(nonatomic,copy)NSString *theme_name;

/** 订阅数 */
@property(nonatomic,assign)NSInteger sub_number;
@end
