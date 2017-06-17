//
//  ZYCEssenceViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/3/17.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCEssenceViewController.h"
#import "ZYCRecommendTagsViewController.h"

#import "ZYCTopicViewController.h"


@interface ZYCEssenceViewController ()<UIScrollViewDelegate>
//标签栏底部的红色指示器
@property(nonatomic,weak)UIView *indicator;

//当前选中的按钮
@property(nonatomic,weak)UIButton *selectedButton;

//标签栏
@property(nonatomic,weak)UIView *titlesView;

//中间的scrollView
@property(nonatomic,weak)UIScrollView *contentView;

@end

@implementation ZYCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZYCLog(@"%@",NSStringFromCGRect(self.view.frame));
    //设置导航栏
    [self setUpNav];
    
    //设置子控件
    [self setUpChildVces];
    
    //设置顶部标签
    [self setTitlesView];
    
    
    
    //设置scrollView
    [self setUpContentView];
    
    
}
//设置子控件
- (void)setUpChildVces
{
    ZYCTopicViewController *all = [[ZYCTopicViewController alloc]init];
    all.title = @"全部";
    all.type = ZYCTopicTypeAll;
    [self addChildViewController:all];
    
    ZYCTopicViewController *video = [[ZYCTopicViewController alloc]init];
    video.title = @"视频";
    video.type = ZYCTopicTypeVideo;
    [self addChildViewController:video];
    
    ZYCTopicViewController *voice = [[ZYCTopicViewController alloc]init];
    voice.title = @"声音";
    voice.type = ZYCTopicTypeVoice;
    [self addChildViewController:voice];
    
    ZYCTopicViewController *picture = [[ZYCTopicViewController alloc]init];
    picture.title = @"图片";
    picture.type = ZYCTopicTypePicture;
    [self addChildViewController:picture];
    
    ZYCTopicViewController *word = [[ZYCTopicViewController alloc]init];
    word.title = @"段子";
    word.type = ZYCTopicTypeWord;
    [self addChildViewController:word];
    
    
}

//设置scrollView
-(void)setUpContentView
{
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc]init];
    
//    contentView.backgroundColor = [UIColor blueColor];
    
    contentView.frame = self.view.bounds;
    
    contentView.delegate =self;
    //分页
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, contentView.height);

    self.contentView = contentView;
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
    
    
}
//设置顶部标签
- (void)setTitlesView
{
    //标签栏整体
    UIView *titlesView = [[UIView alloc]init];
    titlesView.frame = CGRectMake(0, ZYCTitlesViewY, self.view.width, ZYCTitlesViewH);
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
    
    
    
    self.indicator = indicator;
    
    //内部的子标签
    
    for ( NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.tag = i;
//        button.y = titlesView.y;
        button.width = self.view.width/self.childViewControllers.count;
        button.height = titlesView.height;
        button.x = i *button.width;
        
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        
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
            UIViewController *vc = self.childViewControllers[i];
            self.indicator.width = [vc.title sizeWithAttributes:@{ NSFontAttributeName : button.titleLabel.font }].width;
            self.indicator.centerX = button.centerX;

        }
    }
    
    [titlesView addSubview:indicator];//保证按钮在指示器前面
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
  
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset = CGPointMake(_contentView.width * button.tag, 0);
    [self.contentView setContentOffset:offset animated:YES];
    
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





#pragma mark - UIScrollViewDelegate
//点击按钮滚动动画结束时运行
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    //当前的索引
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    
    //取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;//设置控制器view的y值为0（自己创建的view的y默认为20）
    vc.view.height = scrollView.height;//设置控制器的view的height值为整个屏幕的高度（默认高度比屏幕高度少20）
    
        
    //添加子控制器的view
    [scrollView addSubview:vc.view];
    

    
}
//左右拖动动画结束时运行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   
  
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //点击按钮
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];//要保证按钮在指示器前面
}

@end
