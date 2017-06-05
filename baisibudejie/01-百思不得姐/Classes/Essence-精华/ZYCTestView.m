//
//  ZYCTestView.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/6.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCTestView.h"

@implementation ZYCTestView

+ (instancetype)testView
{
    return [[self alloc]init];
    
}

- (void)setFrame:(CGRect)frame
{
    
    frame.size = CGSizeMake(100, 100);
    
    [super setFrame:frame];
    
}

- (void)setBounds:(CGRect)bounds
{
    bounds.size = CGSizeMake(100, 100);
    
    [super setBounds:bounds];
}
@end
