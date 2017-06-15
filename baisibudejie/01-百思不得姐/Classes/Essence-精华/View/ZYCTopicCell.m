//
//  ZYCTopicCell.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/15.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCTopicCell.h"
#import "UIImageView+WebCache.h"
#import "ZYCTopic.h"
@interface ZYCTopicCell()


@property (weak, nonatomic) IBOutlet UIImageView *headImageView;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
@implementation ZYCTopicCell

//- (void)setTopic:(ZYCTopic *)topic
//{
//    self.topic = topic;
////        self.nameLabel.text = topic.name;
////        self.timeLabel.text = topic.text;
////        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
//    
//    
//}

- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    
    frame.origin.x += margin;
    frame.size.width -= 2 *margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    
    [super setFrame:frame];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgview = [[UIImageView alloc] init];
    bgview.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgview;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end


