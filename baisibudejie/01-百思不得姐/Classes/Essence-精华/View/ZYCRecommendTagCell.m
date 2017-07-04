//
//  ZYCRecommendTagCell.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/5.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCRecommendTagCell.h"
#import "ZYCRecommendTag.h"
#import "UIImageView+WebCache.h"
@interface ZYCRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;
@end

@implementation ZYCRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRecommendTag:(ZYCRecommendTag *)recommendTag
{
    
    _recommendTag = recommendTag;
    
    
//    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list]];
    [self.imageListImageView setHeader:recommendTag.image_list];
    
    self.themeNameLabel.text = recommendTag.theme_name;
    
    NSString *subNmuber = nil;
    if (recommendTag.sub_number < 10000) {
        subNmuber = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    } else {//大于等于10000
        subNmuber = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNmuber;
}

- (void)setFrame:(CGRect)frame
{
    
    
//    frame.origin.x = 5;
//    frame.size.width -= 2 *self.frame.origin.x;
    frame.size.height -= 1;
    
    //交给父类
    [super setFrame:frame];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
