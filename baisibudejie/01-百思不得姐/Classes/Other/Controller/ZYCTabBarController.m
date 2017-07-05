//
//  ZYCTabBarController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/3/15.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCTabBarController.h"
#import "ZYCEssenceViewController.h"
#import "ZYCNewViewController.h"
#import "ZYCMeViewController.h"
#import "ZYCFriendTrendsViewController.h"

#import "ZYCNavigationController.h"

#import "ZYCTabBar.h"

@interface ZYCTabBarController ()

@end

/**
 *
 [UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#> blue:<#(CGFloat)#> alpha:<#(CGFloat)#>];
 颜色:
 
 24bit颜色: R G B
 * #ff0000
 * #ccee00
 * #000000
 * #ffffff
 
 32bit颜色: ARGB
 * #ff0000ff
 
 常见颜色:
 #ff0000 红色
 #00ff00 绿色
 #0000ff 蓝色
 #000000 黑色
 #ffffff 白色
 
 灰色的特点:RGB一样
 
 1024x1024像素的图片  32bit颜色
 
 1024x1024x32\8 == 1024x1024x4
 1024x1024x24\8 == 1024x1024x3
 */



@implementation ZYCTabBarController


+ (void)initialize
{
    
    
    
    //通过appearance统一设置UITabBarItem所有文字属性
    //后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance对象统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    
    //添加子控制器
    [self setUpChildVc:[[ZYCEssenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setUpChildVc:[[ZYCNewViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setUpChildVc:[[ZYCFriendTrendsViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setUpChildVc:[[ZYCMeViewController alloc]initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //更换tabbar
    [self setValue:[[ZYCTabBar alloc]init] forKeyPath:@"tabBar"];
    
   
    
}

//初始化子控制器
- (void)setUpChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{

    //设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    //包装一个导航控制器， 添加导航控制器为tabbarcontroller的子控制器
    ZYCNavigationController *nav = [[ZYCNavigationController alloc]initWithRootViewController:vc];
 
    
    [self addChildViewController:nav];

    
    
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
