//
//  ZYCEssenceViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/3/17.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCEssenceViewController.h"
#import "ZYCRecommendTagsViewController.h"

#import "ZYCTestView.h"
@interface ZYCEssenceViewController ()

@end

@implementation ZYCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZYCTestView *test = [ZYCTestView testView];
    
    test.frame = CGRectMake(100, 100, 10, 10);
    test.backgroundColor = [UIColor redColor];
    [self.view addSubview:test];
    
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左边按钮
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIcon" target:self action:@selector(tagClick)];
    //设置背景色
    self.view.backgroundColor = ZYCGlobalBG;
    
    
}


- (void)tagClick
{
    ZYCRecommendTagsViewController *tags = [[ZYCRecommendTagsViewController alloc]init];
    //加载推荐标签页
    [self.navigationController pushViewController:tags animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = ZYCRGBColor(200, 120, 35);
    [self.navigationController pushViewController:vc animated:YES];
    ZYCLog(@"%@",self.navigationController);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
