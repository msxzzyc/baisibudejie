//
//  ZYCPostWordViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/6.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCPostWordViewController.h"
#import "ZYCPlaceholderTextView.h"
@interface ZYCPostWordViewController ()
/** 文本输入控件 */
@property(nonatomic,strong)ZYCPlaceholderTextView *textView;
@end

@implementation ZYCPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpTextView];
    
}

- (void)setUpTextView
{
   
    ZYCPlaceholderTextView *textView = [[ZYCPlaceholderTextView alloc]init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"发好玩儿的段子";
    textView.placeholderColor = [UIColor redColor];
    [self.view addSubview:textView];
    
    self.textView = textView;
}

- (void)setUpNav
{
    
    self.title = @"发表文字";
    //    self.navigationItem.titleView =
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    //    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
    //    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;//默认不能点击
    //强制刷新
    //    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)cancel
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    self.textView.placeholderColor = [UIColor blueColor];
//    self.textView.placeholder = @"hehhehehhehhehhehehhe";
//    self.textView.font = [UIFont systemFontOfSize:30];
    
    //注意以下方法修改文字不会被监听到，所以必须重写setter方法
//    self.textView.text = @"hhhhhhhhhhhhhhhhhh";
    
    
}

- (void)post
{
    ZYCLogFunc;
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
