//
//  ZYCTopicPictureView.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/19.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCTopicPictureView.h"
#import "ZYCTopic.h"
#import "UIImageView+WebCache.h"
@interface ZYCTopicPictureView()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** git标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;

/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;



@end
@implementation ZYCTopicPictureView

- (void)awakeFromNib
{
    //如果设置的控件尺寸变大，一般是autoresizingMask导致的问题
    self.autoresizingMask = UIViewAutoresizingNone;
}

+ (instancetype)pictureView
{
    
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}

- (void)setTopic:(ZYCTopic *)topic
{
    
    _topic = topic;
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage]];
    //判断是否为gif
    NSString *extention = topic.largeImage.pathExtension;
    
    self.gifView.hidden = ![[extention lowercaseString] isEqualToString:@"gif"];//利用图片扩展名判断图片类型，可能不够严谨
    
    //在不知道图片扩展名的情况下，取出图片数据的第一个字节，就可以判断图片类型（sd-webImage用此法）
    
//    self.gifView.hidden = !topic.is_gif;
    
    // 判断是否显示"点击查看全图"按钮
    if (topic.isBigPicture) {
        self.seeBigBtn.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    } else {
        self.seeBigBtn.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
  
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
