//
//  ZYCAddTagViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/24.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCAddTagViewController.h"
#import "ZYCTagButton.h"
#import "ZYCTagTextField.h"
@interface ZYCAddTagViewController ()<UITextFieldDelegate>
/** 内容 容器 */
@property(nonatomic,weak)UIView *contentView;
/** 文本输入框 */
@property(nonatomic,weak)ZYCTagTextField *textField;
/** 添加按钮 */
@property(nonatomic,weak)UIButton *addButton;
/** 所有的标签按钮 */
@property(nonatomic,strong)NSMutableArray *tagButtons;
@end

@implementation ZYCAddTagViewController
#pragma mark - 懒加载
- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}
- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.width = self.contentView.width;
        addButton.height = 35;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //让按钮内部的文字和图片都左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, ZYCTagMargin, 0, ZYCTagMargin);
        addButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.backgroundColor = ZYCTagBG;
        [self.contentView addSubview:addButton];
        _addButton = addButton;
    }
    
    return _addButton;
}
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self setContentView];
    [self setTextField];
}
- (void)setContentView
{
    UIView *contentView = [[UIView alloc]init];
    contentView.x = ZYCTagMargin;
    contentView.y = 64 + ZYCTagMargin;
    contentView.width = ZYCScreenW - 2*ZYCTagMargin;
    contentView.height = ZYCScreenH;
    [self.view addSubview:contentView];
    
    self.contentView = contentView;
}
- (void)setTextField
{
    ZYCTagTextField *textField = [[ZYCTagTextField alloc]init];
    textField.delegate = self;
    textField.width = self.contentView.width;
    textField.height = 25;
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    //设置了占位文字内容以后，才可以设置其颜色
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];

    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [textField becomeFirstResponder];
    [self.contentView addSubview:textField];
    
    self.textField = textField;
    
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
#pragma mark - 监听文字改变
/**
 *监听文字改变
 */
- (void)textDidChange
{
    //更新textField的frame
    [self updateTextFieldFrame];
    if (self.textField.hasText) {//有文字
        //显示"添加标签"的按钮
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + ZYCTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textField.text] forState:UIControlStateNormal];
        
        //获得最后一个字符串
        NSUInteger len = self.textField.text.length;
        NSString *lastLetter = [self.textField.text substringFromIndex:len-1];
        if (([lastLetter isEqualToString:@","]||[lastLetter isEqualToString:@"，"])&& len > 1) {
            //去掉逗号
            self.textField.text = [self.textField.text substringToIndex:len-1];
            [self addButtonClick];
        }
    }else{//没有文字
        //隐藏"添加标签"的按钮
        self.addButton.hidden = YES;
    }
    
}
#pragma mark - 监听按钮点击
/**
 *监听"添加标签"按钮的点击
 */
- (void)addButtonClick
{
    //添加一个"标签按钮"
    ZYCTagButton *tagButton = [ZYCTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    tagButton.height = self.textField.height;
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:tagButton];
    
    [self.tagButtons addObject:tagButton];
    //更新标签按钮和textField的frame
    [self updateTagButtonFrame];
    [self updateTextFieldFrame];
    //清空textField的文字
    self.textField.text = nil;
    self.addButton.hidden = YES;
}
/**
 *标签按钮的点击
 */
- (void)tagButtonClick:(UIButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    //更新标签按钮和textField的frame
    
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        [self updateTextFieldFrame];
    }];
}
#pragma mark - 子控件frame处理
/**
 *专门用来更新标签按钮的frame
 */
- (void)updateTagButtonFrame
{
    //更新标签按钮的frame
    for (int i=0; i<self.tagButtons.count; i++) {
        ZYCTagButton *tagButton = self.tagButtons[i];
        if (i==0) {//最前面的标签按钮
            tagButton.x = 0;
            tagButton.y = 0;
        }else{//其他标签按钮
            ZYCTagButton *lastTagButton = self.tagButtons[i-1];
            //计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame)+ZYCTagMargin;
            //计算当前行右边剩余的宽度
            CGFloat rightWidth = self.contentView.width-CGRectGetMaxX(lastTagButton.frame) - ZYCTagMargin;
            if (rightWidth >= tagButton.width) {//按钮显示在当前行
                tagButton.x = leftWidth;
                tagButton.y = lastTagButton.y;
            }else{//按钮显示在下一行
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame)+ZYCTagMargin;
            }
        }
    }
}
/**
 *更新textField的frame
 */
- (void)updateTextFieldFrame
{
    //最后一个标签按钮
    ZYCTagButton *lastTagButton = [self.tagButtons lastObject];
    //计算当前行左边的宽度
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame)+ZYCTagMargin;
    if (self.contentView.width -leftWidth >= self.textFieldTextWidth) {
        self.textField.x = leftWidth;
        self.textField.y = lastTagButton.y;
    }else{
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagButton.frame)+ ZYCTagMargin;
    }
}

- (CGFloat)textFieldTextWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;//不换行可用此方法算尺寸
    return MAX(100, textW);
}
#pragma mark - UITextFieldDelegate
/**
 *监听键盘最右下角按钮的点击（return key，换行or完成等）
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
    
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
