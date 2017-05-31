//
//  ZYCMeViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/3/17.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCMeViewController.h"

@interface ZYCMeViewController ()

@end

@implementation ZYCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏标题
    self.navigationItem.title = @"我的";
    
    //设置导航栏右边按钮
   
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    
    //设置背景色
    self.view.backgroundColor = ZYCGlobalBG;

}
- (void)settingClick
{
    NSLog(@"%s",__func__);
    
}

- (void)moonClick
{
    NSLog(@"%s",__func__);
    
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
