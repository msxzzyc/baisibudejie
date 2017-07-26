//
//  ZYCTagButton.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/26.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCTagButton.h"

@implementation ZYCTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.backgroundColor = ZYCTagBG;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width += 3*ZYCTagMargin;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = ZYCTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + ZYCTagMargin;
}
@end
