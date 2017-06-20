//
//  ZYCProgressView.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/20.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCProgressView.h"

@implementation ZYCProgressView

- (void)awakeFromNib
{
    [super awakeFromNib];
    //设置进度条圆角
    self.roundedCorners = 2;
    //设置进度条label颜色
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
     self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress*100];//保留0位小数的浮点数
}
@end
