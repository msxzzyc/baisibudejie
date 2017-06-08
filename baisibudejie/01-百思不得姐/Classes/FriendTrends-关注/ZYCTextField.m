//
//  ZYCTextField.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/8.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCTextField.h"

@implementation ZYCTextField

-(void)drawPlaceholderInRect:(CGRect)rect
{
    [self.placeholder drawInRect:CGRectMake(0, 15, self.width, 25) withAttributes:@{
                                                                                    NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : self.font }];
    
}




@end
