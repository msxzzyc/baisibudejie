//
//  ZYCRecommendCategoryCell.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/1.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCRecommendCategoryCell.h"
#import "ZYCRecommendCategory.h"
@interface ZYCRecommendCategoryCell()

//选中时显示的指示器控件
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end
@implementation ZYCRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = ZYCRGBColor(244, 244, 244);
    
    self.selectedIndicator.backgroundColor = ZYCRGBColor(219, 21, 26);
//    self.textLabel.textColor = ZYCRGBColor(78, 78, 78);
    
//    self.textLabel.highlightedTextColor = ZYCRGBColor(219, 21, 26);
    
//    UIView *bg = [[UIView alloc]init];
//    
//    bg.backgroundColor = [UIColor clearColor];
//    self.selectedBackgroundView = bg;
}

- (void)setCategory:(ZYCRecommendCategory *)category
{
    
    _category = category;
    
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.y = 2;
    
    self.textLabel.height = self.contentView.height - 2*self.textLabel.y;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    ZYCLog(@"--------%d",selected);
    
    self.selectedIndicator.hidden = !selected;
    
    self.textLabel.textColor = selected ? ZYCRGBColor(219, 21, 26) : ZYCRGBColor(78, 78, 78);
    
}
@end
