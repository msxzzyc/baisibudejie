//
//  ZYCCommentCell.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/30.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCCommentCell.h"
#import "ZYCComment.h"
#import "ZYCUser.h"
#import "UIImageView+WebCache.h"
@interface ZYCCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profile_imageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *like_countLabel;

@end

@implementation ZYCCommentCell

+ (instancetype)commentCell
{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setComment:(ZYCComment *)comment
{
    _comment = comment;
    
    
    [self.profile_imageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.sexImageView.image =  [comment.user.sex isEqualToString:ZYCUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.usernameLabel.text = comment.user.username;
    
    self.contentLabel.text = comment.content;
    
    self.like_countLabel.text =  [NSString stringWithFormat:@"%zd",comment.like_count];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
