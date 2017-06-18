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

- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return selfYear == nowYear;
}
//- (BOOL)isToday
//{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
//    NSDateComponents *nowCmp = [calendar components:unit fromDate:[NSDate date]];
//    NSDateComponents *selfCmp = [calendar components:unit fromDate:self];
//    return selfCmp.year == nowCmp.year && selfCmp.month == nowCmp.month && selfCmp.day == nowCmp.day;
//}

- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    return [selfString isEqualToString:nowString];
}
- (BOOL)isYestoday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *cmp = [calendar components:unit fromDate:selfDate toDate:nowDate options:nil];
    return cmp.year == 0&&cmp.month == 0&&cmp.day == 1;
}

@end
