//
//  ZYCAddTagToolbar.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/24.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCAddTagToolbar.h"
#import "ZYCAddTagViewController.h"
@interface ZYCAddTagToolbar()
@property (weak, nonatomic) IBOutlet UIView *topView;

@end
@implementation ZYCAddTagToolbar

- (void)awakeFromNib
{
    [super awakeFromNib];
    //添加一个加号
    UIButton *addButton = [[UIButton alloc]init];
    
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //依据图片大小确定按钮大小
//    addButton.size = [UIImage imageNamed:@"tag_add_icon"].size;
//    addButton.size = [addButton imageForState:UIControlStateNormal].size;
    addButton.size = addButton.currentImage.size;
    addButton.x = ZYCTagMargin;
    [self.topView addSubview:addButton];
    
    
}

- (void)addButtonClick
{
    ZYCAddTagViewController *addtagVc = [[ZYCAddTagViewController alloc]init];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
  
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    [nav pushViewController:addtagVc animated:YES];
    //a modal 出b
//    a.presentedViewController ->b
//    b.presentingViewController - >a
    
}




@end
