//
//  ZYCMeCell.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/5.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCMeCell.h"

@implementation ZYCMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *bgview = [[UIImageView alloc] init];
        bgview.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgview;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.image == nil) return;
    
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    
    self.imageView.centerY = self.contentView.height*0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame)+ ZYCTopicCellMargin;
    
    
}

//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y -= (35 - ZYCTopicCellMargin);
//    
//    [super setFrame:frame];
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
