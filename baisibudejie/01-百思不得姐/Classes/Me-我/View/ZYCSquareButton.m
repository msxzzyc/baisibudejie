//
//  ZYCSquareButton.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/5.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCSquareButton.h"
#import "ZYCSquare.h"
#import "UIButton+WebCache.h"
@implementation ZYCSquareButton
- (void)setUp
{
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];

    
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

    self.imageView.y = self.height*0.15;
    self.imageView.width = self.width*0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width*0.5;
    
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

- (void)setSquare:(ZYCSquare *)square
{
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    
    //用sdImage给按钮设置image
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
