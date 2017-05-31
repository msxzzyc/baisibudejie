//
//  ZYCNavigationController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/3/19.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCNavigationController.h"

@interface ZYCNavigationController ()

@end

@implementation ZYCNavigationController

//当第一次使用这个类时会调用一次
+ (void)initialize
{
    //当导航栏用在ZYCNavigationController中时，才会生效
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    
//    UINavigationBar *bar = [UINavigationBar appearance];
//    
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    ZYCLogFunc;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    

    
    
}


//可以在这个方法中拦截所有的push进来的控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count>0) {//如果push进来的不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        //让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [button sizeToFit];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
//这句super的push要放在后面，让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    
}

- (void)back
{
    [self popViewControllerAnimated:YES];
    
}

@end
