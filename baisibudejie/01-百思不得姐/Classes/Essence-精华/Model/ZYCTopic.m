//
//  ZYCTopic.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/12.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCTopic.h"

@implementation ZYCTopic
- (NSString *)create_time
{
    //日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //设置日期格式
    fmt.dateFormat = @"yyyy-MM-dd-HH-mm-ss";
    //发帖时间
    NSDate *create = [fmt dateFromString:_create_time];
    //当前时间
    NSDate *now = [NSDate date];
    if ([create isThisYear]) {//今年
        NSDateComponents *createCmp = [now deltaFrom:create];
        if ([create isToday]){//今天
            
            if (createCmp.hour >= 1) {//时间差距>=1小时
                return [NSString stringWithFormat:@"%zd小时前",createCmp.hour];
            }else if (createCmp.minute>=1){// 1小时>时间差距>=
                return [NSString stringWithFormat:@"%zd分钟前",createCmp.minute];
                
                
            }else{//1分钟>时间差距
                return @"刚刚";
            }
            
        }else if ([create isYestoday]){//昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }else{//其他
            
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
        
    }else{//非今年
        return _create_time;
        
    }

    
}
@end
