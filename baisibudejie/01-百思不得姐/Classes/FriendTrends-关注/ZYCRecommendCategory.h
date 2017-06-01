//
//  ZYCRecommendCategory.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/1.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCRecommendCategory : NSObject
/** 总数 */
@property(nonatomic,assign)NSInteger count;
/** id */
@property(nonatomic,assign)NSInteger id;
/** 名字 */
@property(nonatomic,copy)NSString *name;
@end
