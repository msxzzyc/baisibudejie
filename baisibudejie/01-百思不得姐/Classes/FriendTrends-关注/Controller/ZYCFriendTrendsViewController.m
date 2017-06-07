//
//  ZYCFriendTrendsViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/3/17.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCFriendTrendsViewController.h"
#import "ZYCRecommendViewController.h"
#import "ZYCLoginRegisterViewController.h"
@interface ZYCFriendTrendsViewController ()

@end

@implementation ZYCFriendTrendsViewController
- (IBAction)loginRegisterBtn:(id)sender {
    
    ZYCLoginRegisterViewController *login = [[ZYCLoginRegisterViewController alloc]init];
    
    [self presentViewController:login animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    //设置导航栏左边按钮
  
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    //设置背景色
    self.view.backgroundColor = ZYCGlobalBG;
    
                                           
}
- (void)friendsClick
{
    ZYCRecommendViewController *vc = [[ZYCRecommendViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    ZYCRecommendViewController *vc = [[ZYCRecommendViewController alloc]init];
    vc.view.backgroundColor = ZYCGlobalBG;
    [self.navigationController pushViewController:vc animated:YES];
    
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
