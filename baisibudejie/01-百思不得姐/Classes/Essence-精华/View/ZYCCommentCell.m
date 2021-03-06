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
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;

@end

@implementation ZYCCommentCell

+ (instancetype)commentCell
{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    //添加背景图片设置分割线
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
//    //头像变圆
//    self.profile_imageView.layer.cornerRadius = self.profile_imageView.width * 0.5;
//    self.profile_imageView.layer.masksToBounds = YES;
}

- (void)setComment:(ZYCComment *)comment
{
    _comment = comment;
    //头像变圆
//    UIImage *placeholderImage = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
//    [self.profile_imageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[[UIImage imageNamed:@"defaultUserIcon"] circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        self.profile_imageView.image = image ? [image circleImage] : placeholderImage;
//        
//     }];
    [self.profile_imageView setHeader:comment.user.profile_image];
    
    self.sexImageView.image =  [comment.user.sex isEqualToString:ZYCUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.usernameLabel.text = comment.user.username;
    
    self.contentLabel.text = comment.content;
    
    self.like_countLabel.text =  [NSString stringWithFormat:@"%zd",comment.like_count];
    
    
    if (comment.voiceuri.length) {//没有音频时voiceuri传来的是空字符串@"",所以要用字符串长度来判断
        self.voiceBtn.hidden = NO;
        self.voiceBtn.titleLabel.text = [NSString stringWithFormat:@"%zd''",comment.voicetime];
        
    }else self.voiceBtn.hidden = YES;
    
    
    
}

- (void)setFrame:(CGRect)frame
{
//    frame.origin.x = ZYCTopicCellMargin;
//    frame.size.width -= 2*ZYCTopicCellMargin;
    
//    frame.size.height -= 1;
    
    [super setFrame:frame];
}
//使cell有资格成为第一响应者
- (BOOL)canBecomeFirstResponder
{
    
    return YES;
    
}
/**
 *cell能执行哪些操作 return yes支持这些操作
 
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    //    if (action == @selector(cut:)||action == @selector(copy:)||action == @selector(paste:)) return YES;
    return NO;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
