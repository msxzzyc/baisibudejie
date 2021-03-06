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
#import "SVProgressHUD.h"
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
- (UIView *)contentView
{
    if (!_contentView) {
       UIView *contentView = [[UIView alloc]init];
        [self.view addSubview:contentView];
        self.contentView = contentView;
    }
    return _contentView;
}
- (ZYCTagTextField *)textField
{
    if (!_textField) {
        ZYCTagTextField *textField = [[ZYCTagTextField alloc]init];
        //防止循环引用
        __weak typeof(self) weakSelf = self;
        textField.delegate = self;
        textField.deleteBlock = ^{
            if (weakSelf.textField.hasText) return ;
            [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
        };
        
        [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
        [textField becomeFirstResponder];
        [self.contentView addSubview:textField];
        self.textField = textField;
    }
    return _textField;
}
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
        addButton.height = 35;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //让按钮内部的文字和图片都左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, ZYCTagMargin, 0, ZYCTagMargin);
        addButton.titleLabel.font = ZYCTagFont;
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
   
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.contentView.x = ZYCTagMargin;
    self.contentView.y = 64 + ZYCTagMargin;
    self.contentView.width = ZYCScreenW - 2*ZYCTagMargin;
    self.contentView.height = ZYCScreenH;
   
    self.textField.width = self.contentView.width;
    
    self.addButton.width = self.contentView.width;
    
    [self setTags];
    
    
}
- (void)setTags
{
    //确保只调用一次
    if (self.tags.count) {
        for (NSString *tag in self.tags) {
            //模拟文本框输入来初始化标签文字
            self.textField.text = tag;
            [self addButtonClick];
            
        }
        self.tags = nil;
    }
    
    
}
- (void)setUpNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}
- (void)done
{
//    NSMutableArray *tags = [NSMutableArray array];
//    for (ZYCTagButton *tagButton in self.tagButtons) {
//        [tags addObject: tagButton.currentTitle];
//    }
    //传递tags给这个block
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.tagsBlock ? : self.tagsBlock(tags);
    [self.navigationController popViewControllerAnimated:YES];
    
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
    if (self.tagButtons.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签" maskType:SVProgressHUDMaskTypeBlack];
        return;
        
    }
    //添加一个"标签按钮"
    ZYCTagButton *tagButton = [ZYCTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
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
    //更新添加标签按钮的frame
    self.addButton.y = CGRectGetMaxY(self.textField.frame) + ZYCTagMargin;
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
