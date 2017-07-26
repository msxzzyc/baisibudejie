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
/** 所有的标签按钮 */
@property(nonatomic,strong)NSMutableArray *tagButtons;
@end

@implementation ZYCAddTagViewController

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
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + ZYCTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textField.text] forState:UIControlStateNormal];
        
        
    }else{//没有文字
        //隐藏"添加标签"的按钮
        self.addButton.hidden = YES;
    }
    //更新标签按钮和textField的frame
    [self updateTagButtonFrame];
}
/**
 *监听"添加标签"按钮的点击
 */
- (void)addButtonClick
{
    //添加一个"标签按钮"
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [tagButton setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    [tagButton sizeToFit];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    tagButton.backgroundColor = ZYCTagBG;
    [self.contentView addSubview:tagButton];
    
    [self.tagButtons addObject:tagButton];
    //更新标签按钮的frame
    [self updateTagButtonFrame];
    //清空textField的文字
    self.textField.text = nil;
    self.addButton.hidden = YES;
}
/**
 *专门用来更新标签按钮的frame
 */
- (void)updateTagButtonFrame
{
    //更新标签按钮的frame
    for (int i=0; i<self.tagButtons.count; i++) {
        UIButton *tagButton = self.tagButtons[i];
        if (i==0) {//最前面的标签按钮
            tagButton.x = 0;
            tagButton.y = 0;
        }else{//其他标签按钮
            UIButton *lastTagButton = self.tagButtons[i-1];
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
    //更新textField的frame
    
    //最后一个标签按钮
    UIButton *lastTagButton = [self.tagButtons lastObject];
    //计算当前行左边的宽度
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame)+ZYCTagMargin;
    if (self.contentView.width -leftWidth >= self.textFieldTextWid) {
        self.textField.x = leftWidth;
        self.textField.y = lastTagButton.y;
    }else{
    self.textField.x = 0;
    self.textField.y = CGRectGetMaxY(lastTagButton.frame)+ ZYCTagMargin;
    }
}
- (CGFloat)textFieldTextWid
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
    return MAX(100, textW);
}
/**
 *标签按钮的点击
 */
- (void)tagButtonClick:(UIButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    //重新更新所有标签按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
    }];
    
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
