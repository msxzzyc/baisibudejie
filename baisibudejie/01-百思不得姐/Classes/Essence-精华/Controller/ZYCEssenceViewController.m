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

//当前选中的按钮
@property(nonatomic,weak)UIButton *selectedButton;

//标签栏
@property(nonatomic,weak)UIView *titlesView;
@end

@implementation ZYCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setUpNav];
    
    //设置顶部标签
    [self titlesView];
    
    //设置scrollView
    [self setUpContentView];
    
    
}
//设置scrollView
-(void)setUpContentView
{
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc]init];
    
    contentView.backgroundColor = [UIColor blueColor];
    
    contentView.frame = self.view.bounds;
    
    //设置内边距
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    CGFloat bottom = self.view.height - self.tabBarController.tabBar.height;
    contentView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    [self.view insertSubview:contentView atIndex:0];
    
}
//设置顶部标签
- (void)setTitlesView
{
    //标签栏整体
    UIView *titlesView = [[UIView alloc]init];
    titlesView.frame = CGRectMake(0, 64, self.view.width, 35);
//    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
//    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    self.titlesView = titlesView;
    
    [self.view addSubview:titlesView];
    
    
    //底部的红色指示器
    UIView *indicator = [[UIView alloc]init];
    
    indicator.backgroundColor = [UIColor redColor];
    indicator.height = 2;
    indicator.y = titlesView.height - indicator.height;
    
    
    [titlesView addSubview:indicator];
    self.indicator = indicator;
    
    //内部的子标签
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    for ( NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        
//        button.y = titlesView.y;
        button.width = self.view.width/titles.count;
        button.height = titlesView.height;
        button.x = i *button.width;
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
//        [button layoutIfNeeded];//强制布局（强制更新子控件的frame）
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        //默认选中第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            //让按钮内部的label根据文字内容来计算尺寸
//            [button.titleLabel sizeToFit];
//            self.indicator.width = button.titleLabel.width;
            
            //直接拿出title计算其所占宽度
            self.indicator.width = [titles[i] sizeWithAttributes:@{ NSFontAttributeName : button.titleLabel.font }].width;
            self.indicator.centerX = button.centerX;

        }
    }
    
    
}

- (void)titleClick:(UIButton *)button
{
    //修改按钮状态
    self.selectedButton.enabled = YES;
    
    button.enabled = NO;
    self.selectedButton = button;
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicator.width = button.titleLabel.width;
        self.indicator.centerX = button.centerX;
        
        

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
