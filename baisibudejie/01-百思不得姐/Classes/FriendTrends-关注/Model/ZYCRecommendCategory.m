//
//  ZYCRecommendCategory.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/1.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCRecommendCategory.h"

@implementation ZYCRecommendCategory

- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
