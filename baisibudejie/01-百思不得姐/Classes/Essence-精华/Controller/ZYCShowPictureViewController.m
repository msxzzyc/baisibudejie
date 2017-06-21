//
//  ZYCShowPictureViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/20.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCShowPictureViewController.h"
#import "ZYCTopic.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
@interface ZYCShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *imageView;

@end

@implementation ZYCShowPictureViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //屏幕尺寸
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    //添加图片
    UIImageView *imageView = [[UIImageView alloc]init];
    
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    //图片尺寸
    //图片显示高度
    CGFloat pictureW = screenW;
    //图片显示高度
    CGFloat pictureH = pictureW * self.topic.height/self.topic.width;
    
    
    if (pictureH > screenH) {//图片高度超过一个屏幕,需要滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
        
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH *0.5;
    }

    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.largeImage] placeholderImage:nil];
    
    
    
}
- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)save:(id)sender {
    //将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image: didFinishSavingWithError: contextInfo:), nil);
    
}
//注意参数未传够导致的参数越界
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
    
}
@end
