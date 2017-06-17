//
//  NSDate+ZYCExtention.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/17.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZYCExtention)
- (NSDateComponents *)deltaFrom:(NSDate *)from;
- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYestoday;



@end
