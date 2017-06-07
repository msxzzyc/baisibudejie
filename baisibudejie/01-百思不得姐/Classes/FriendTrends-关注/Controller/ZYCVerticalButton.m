//
//  ZYCVerticalButton.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/7.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCVerticalButton.h"

@implementation ZYCVerticalButton

- (void)setUp
{
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    
    return self;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

@end
