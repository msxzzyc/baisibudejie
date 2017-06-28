//
//  ZYCTopicVideoView.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/28.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCTopicVideoView.h"
#import "ZYCTopic.h"
#import "UIImageView+WebCache.h"
#import "ZYCShowPictureViewController.h"
@interface ZYCTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;

@end
@implementation ZYCTopicVideoView

+ (instancetype)videoView
{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    //如果设置的控件尺寸变大，一般是autoresizingMask导致的问题
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture
{
    
    ZYCLogFunc;
    
    
    ZYCShowPictureViewController *showPictureVc = [[ZYCShowPictureViewController alloc]init];
    
    showPictureVc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureVc animated:YES completion:nil];
}

- (void)setTopic:(ZYCTopic *)topic
{
    _topic = topic;
    
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage] placeholderImage:nil options:0];
    //时长
    NSInteger minute = topic.videotime/60;
    NSInteger second = topic.videotime % 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd : %02zd",minute,second];
    //播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
}
@end
