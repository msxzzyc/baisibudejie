//
//  ZYCLoginRegisterViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/7.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCLoginRegisterViewController.h"

@interface ZYCLoginRegisterViewController ()
//@property (weak, nonatomic) IBOutlet UITextField *phoneField;
/** 登录框距离控制器view左边框的间距*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
@end

@implementation ZYCLoginRegisterViewController
- (IBAction)loginOrRegister: (UIButton *)button
{
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.leftMargin.constant == 0) {//显示注册界面
        self.leftMargin.constant = - self.view.width;
//        [button setTitle:@"已有账号？" forState:UIControlStateNormal];
        
        button.selected = YES;
        
    } else {//显示登录界面
        self.leftMargin.constant = 0;
//        [button setTitle:@"注册账号" forState:UIControlStateNormal];
        button.selected = NO;
        
    }
  
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
}
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //文字属性
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    //NSAttributedString：带有属性的文本（富文本属性）
//    NSAttributedString *placeholder = [[NSAttributedString alloc]initWithString:@"手机号" attributes:attrs];
//    
//    self.phoneField.attributedPlaceholder = placeholder;
    
    
//    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:@"手机号"];
//    
//    [placeholder setAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} range:NSMakeRange(0, 1)];
//    
//    [placeholder setAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor],
//                                 NSFontAttributeName : [UIFont systemFontOfSize:26]                       } range:NSMakeRange(1, 1)];
//    [placeholder setAttributes:@{NSForegroundColorAttributeName : [UIColor yellowColor]} range:NSMakeRange(2, 1)];
//    self.phoneField.attributedPlaceholder = placeholder;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleLightContent;
}
@end
