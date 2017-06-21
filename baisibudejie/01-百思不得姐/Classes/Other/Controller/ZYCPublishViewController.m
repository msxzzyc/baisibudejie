//
//  ZYCPublishViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/21.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCPublishViewController.h"
#import "ZYCVerticalButton.h"
@interface ZYCPublishViewController ()

@end

@implementation ZYCPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //添加slogan(标语)
    UIImageView *slogan = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    slogan.centerX = ZYCScreenW *0.5;
    slogan.centerY = ZYCScreenH *0.2;
    [self.view addSubview:slogan];
    
    
    //数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text",@"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];

    //中间的6个按钮
    int maxCols = 3;
    CGFloat startX = 25;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    
    for (int i = 0; i < images.count; i++) {
        
        ZYCVerticalButton *button = [[ZYCVerticalButton alloc]init];
        
        //设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //设置frame
        CGFloat row = i / 3;
        CGFloat col = i % 3;
        
        CGFloat xMargin = (ZYCScreenW - 2*startX - maxCols*buttonW)/(maxCols -1);
        button.x = startX + col*(buttonW + xMargin);
        button.y = (ZYCScreenH - 2*buttonH)/2 + row *buttonH;
        button.width = buttonW;
        button.height = buttonH;
//        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        
        [self.view addSubview:button];
        
        
    }
    
}
- (IBAction)cancelBtn {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
