//
//  ZYCEssenceViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/3/17.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCEssenceViewController.h"
#import "ZYCRecommendTagsViewController.h"


@interface ZYCEssenceViewController ()
//标签栏底部的红色指示器
@property(nonatomic,weak)UIView *indicator;
@end

@implementation ZYCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setUpNav];
    
    //设置顶部标签
    [self titlesView];
    
    
    
}

//设置顶部标签
- (void)titlesView
{
    //标签栏整体
    UIView *titlesView = [[UIView alloc]init];
    titlesView.frame = CGRectMake(0, 64, self.view.width, 35);
//    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
//    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    [self.view addSubview:titlesView];
    
    //内部的子标签
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    for ( NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        
//        button.y = titlesView.y;
        button.width = self.view.width/titles.count;
        button.height = titlesView.height;
        button.x = i *button.width;
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
    }
    
    //底部的红色指示器
    UIView *indicator = [[UIView alloc]init];
    
    indicator.backgroundColor = [UIColor redColor];
    indicator.height = 2;
    indicator.y = titlesView.height - indicator.height;
   
    
    [titlesView addSubview:indicator];
    self.indicator = indicator;
}

- (void)titleClick:(UIButton *)button
{
    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.centerX = button.centerX;
        
        self.indicator.width = button.titleLabel.width;

    }];
  
}

//设置导航栏
- (void)setUpNav
{
    
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
