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
#import "ZYCTopicPictureView.h"
#import "ZYCTopicVoiceView.h"
@interface ZYCTopicCell()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 发帖时间 */
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 新浪加v */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVview;
/** 文字信息 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;
/** 图片帖子中间的内容 */
@property(weak,nonatomic)ZYCTopicPictureView *pictureView;
/** 声音帖子中间的内容 */
@property(weak,nonatomic)ZYCTopicVoiceView *voiceView;

@end
@implementation ZYCTopicCell
- (ZYCTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        ZYCTopicVoiceView *voiceView = [ZYCTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (ZYCTopicPictureView *)pictureView
{
    if (!_pictureView) {
        
        ZYCTopicPictureView *pictureView = [ZYCTopicPictureView pictureView];
        //由于pictureView为弱指针，所以一创建就要添加上去
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

//- (void)setTopic:(ZYCTopic *)topic
//{
//    self.topic = topic;
////        self.nameLabel.text = topic.name;
////        self.timeLabel.text = topic.text;
////        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
//    
//    
//}

- (void)setTopic:(ZYCTopic *)topic
{
    _topic = topic;
    
    //设置其他控件
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    //发帖时间
    self.creatTimeLabel.text = topic.create_time;

//    NSTimeInterval delta = [now timeIntervalSinceDate:create];

//    topic.is_vip = arc4random_uniform(100) % 2;
    //新浪加v
//    self.sinaVview.hidden == !topic.isVip;
    
    //设置帖子文字数据
    self.text_label.text = topic.text;
    
    //根据模型类型（帖子类型）添加对应的图片内容到中间
    if (topic.type == ZYCTopicTypePicture) {//图片帖子
        //pictureView第一次调用get方法就创建并添加上去，所以无需再添加
        
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureViewFrame;
        
    } else if (topic.type == ZYCTopicTypeVoice){//声音帖子
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceViewFrame;
        
    }
    //设置按钮文字
    [self setUpButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setUpButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setUpButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setUpButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
   
    
}

- (void)setUpButtonTitle: (UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
//    NSString *title = nil;
//    if (count == 0) {
//        title = placeholder;
//    }else if (count > 10000) {
//        title = [NSString stringWithFormat:@"%.1f万",count/10000.0];
//    }else{
//        title = [NSString stringWithFormat:@"%zd",count];
//    }
    
    
        if (count == 0) {
            placeholder = placeholder;
        }else if (count > 10000) {
            placeholder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
        }else{
            placeholder = [NSString stringWithFormat:@"%zd",count];
        }
    
    [button setTitle:placeholder forState:UIControlStateNormal];
    
}
- (void)setFrame:(CGRect)frame
{
    
    
    frame.origin.x += ZYCTopicCellMargin;
    frame.size.width -= 2 *ZYCTopicCellMargin;
    frame.size.height -= ZYCTopicCellMargin;
    frame.origin.y += ZYCTopicCellMargin;
    
    
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


