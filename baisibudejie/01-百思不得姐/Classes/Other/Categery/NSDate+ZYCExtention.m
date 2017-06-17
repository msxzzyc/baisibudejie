//
//  NSDate+ZYCExtention.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/17.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "NSDate+ZYCExtention.h"

@implementation NSDate (ZYCExtention)
- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //比较时间
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;

    return  [calendar components:unit fromDate:from toDate:self options:nil]; 
}
@end
