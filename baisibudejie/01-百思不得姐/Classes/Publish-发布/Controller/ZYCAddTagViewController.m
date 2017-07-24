//
//  ZYCAddTagViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/24.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCAddTagViewController.h"

@interface ZYCAddTagViewController ()
/** 内容 容器 */
@property(nonatomic,weak)UIView *contentView;
@end

@implementation ZYCAddTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self setContentView];
    [self setTextField];
}
- (void)setContentView
{
    UIView *contentView = [[UIView alloc]init];
    contentView.x = ZYCTopicCellMargin;
    contentView.y = 64 + ZYCTopicCellMargin;
    contentView.width = ZYCScreenW - 2*ZYCTopicCellMargin;
    contentView.height = ZYCScreenH;
    [self.view addSubview:contentView];
    
    self.contentView = contentView;
}
- (void)setTextField
{
    UITextField *textField = [[UITextField alloc]init];
    textField.width = ZYCScreenW;
    textField.height = 25;
    textField.placeholder = @"多个标签用逗号或者换行隔开";

    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textField];
    
}
/**
 *监听文字改变
 */
- (void)textDidChange
{
    ZYCLogFunc;
}
- (void)setUpNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(Done)];
}
- (void)Done
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
