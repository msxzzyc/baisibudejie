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
/** 文本输入框 */
@property(nonatomic,weak)UITextField *textField;
/** 添加按钮 */
@property(nonatomic,weak)UIButton *addButton;
@end

@implementation ZYCAddTagViewController

- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.width = self.contentView.width;
        addButton.height = 35;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //让按钮内部的文字和图片都左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, ZYCTopicCellMargin, 0, ZYCTopicCellMargin);
        addButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.backgroundColor = ZYCRGBColor(74, 139, 209);
        [self.contentView addSubview:addButton];
        _addButton = addButton;
    }
    
    return _addButton;
}

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
    [textField becomeFirstResponder];
    [self.contentView addSubview:textField];
    
    self.textField = textField;
    
}
/**
 *监听文字改变
 */
- (void)textDidChange
{
    if (self.textField.hasText) {//有文字
        //显示"添加标签"的按钮
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + ZYCTopicCellMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textField.text] forState:UIControlStateNormal];
        
        
    }else{//没有文字
        //隐藏"添加标签"的按钮
        self.addButton.hidden = YES;
    }
    
}
/**
 *监听"添加标签"按钮的点击
 */
- (void)addButtonClick
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
