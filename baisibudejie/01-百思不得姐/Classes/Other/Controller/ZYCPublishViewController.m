//
//  ZYCPublishViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/21.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCPublishViewController.h"
#import "ZYCVerticalButton.h"
#import <POP.h>
static CGFloat const ZYCAnimationDelay = 0.1;
static CGFloat const ZYCSpringFactor = 6;
@interface ZYCPublishViewController ()

@end

@implementation ZYCPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        //设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //计算x/y
        
        CGFloat row = i / 3;
        CGFloat col = i % 3;
        
        CGFloat xMargin = (ZYCScreenW - 2*startX - maxCols*buttonW)/(maxCols -1);
        CGFloat buttonX = startX + col*(buttonW + xMargin);
        CGFloat buttonEndY = (ZYCScreenH - 2*buttonH)/2 + row *buttonH;
        CGFloat buttonStartY = buttonEndY - ZYCScreenH;
//        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //为按钮添加动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonStartY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = ZYCSpringFactor;
        anim.springSpeed = ZYCSpringFactor;
        anim.beginTime = CACurrentMediaTime() + ZYCAnimationDelay*i;
        [button pop_addAnimation:anim forKey:nil];
    }
    //添加slogan(标语)
    UIImageView *slogan = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    CGFloat sloganCenterX = ZYCScreenW *0.5;
    
    CGFloat sloganCenterEndY = ZYCScreenH *0.2;
    CGFloat sloganCenterStartY = sloganCenterEndY - ZYCScreenH;
    [self.view addSubview:slogan];
    
    //为slogan添加动画
    POPSpringAnimation *sloganAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    sloganAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(sloganCenterX, sloganCenterStartY)];
    sloganAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(sloganCenterX, sloganCenterEndY)];
    sloganAnim.springBounciness = ZYCSpringFactor;
    sloganAnim.springSpeed = ZYCSpringFactor;
    sloganAnim.beginTime = CACurrentMediaTime() + ZYCAnimationDelay*images.count;
    [slogan pop_addAnimation:sloganAnim forKey:nil];
    
}

- (void)buttonClick:(UIButton *)button
{
    
        [self cancelWithCompletionBlock:^{
            if (button.tag == 0) {
            ZYCLog(@"发视频");
            }
        }];
    
    
}
/**
 先执行退出动画，动画完毕后执行completionBlock
 */
- (void)cancelWithCompletionBlock:(void(^)())completionBlock
{
    //    ZYCLog(@"%@",self.view.subviews);
    
    //让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    
    int beginIndex = 2;
    //添加动画
    //利用for循环self.view子控件拿到按钮和标语
    for (int i = beginIndex; i < self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        //基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerX = subview.centerX;
        CGFloat centerY = subview.centerY + ZYCScreenH;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.beginTime = CACurrentMediaTime() + ZYCAnimationDelay*(i - beginIndex);
        [subview pop_addAnimation:anim forKey:nil];
        //监听最后一个动画
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished){
                [self dismissViewControllerAnimated:NO completion:nil];
                //执行传进来的completionBlock参数
//                if (completionBlock) {
//                    completionBlock();
//                }
                !completionBlock ? :completionBlock();
            }];
        }
    }
}

- (IBAction)cancelBtn {
    [self cancelWithCompletionBlock:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancelWithCompletionBlock:nil];
}
/**
 pop和Core Animation的区别
 1.Core Animation的动画只能添加到layer上
 2.pop的动画能添加到任何对象
 3.pop的底层并非基于Core Animation, 是基于CADisplayLink
 4.Core Animation的动画仅仅是表象, 并不会真正修改对象的frame\size等值
 5.pop的动画实时修改对象的属性, 真正地修改了对象的属性
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
    

@end
