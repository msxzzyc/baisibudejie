//
//  ZYCRecommendCategory.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/1.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCRecommendCategory.h"
//#import "MJExtension.h"

@implementation ZYCRecommendCategory

- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
//方便统一处理属性名
+ (NSString *)replacedKeyFromPropertyName121:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"ID"]) {
        return @"id";
    }
    
    return propertyName;
    


}

@end
