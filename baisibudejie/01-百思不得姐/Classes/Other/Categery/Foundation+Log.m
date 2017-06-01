//
//  NSDictionary+Log.m
//  05- 多值参数
//
//  Created by wpzyc on 2017/4/15.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *string = [NSMutableString string];
    //开头{
    [string appendString:@"{\n"];
    //遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [string appendFormat:@"\t%@",key];
        [string appendString:@":"];
        [string appendFormat:@"%@,\n",obj];
        
    }];
    
    
    //结尾}
    [string appendString:@"}"];
    
    //查找最后一个逗号并删除
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location !=NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    
    
    
    return string;
    
}

@end

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *string = [NSMutableString string];
    //开头[
    [string appendString:@"[\n"];
    //遍历所有的数组元素
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [string appendFormat:@"\t%@,\n",obj];
        
    }];
    
    
    //结尾]
    [string appendString:@"]"];
    
    //查找最后一个逗号并删除
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location !=NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    return string;
    
}

@end
