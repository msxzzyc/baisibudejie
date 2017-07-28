//
//  ZYCPostWordViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/6.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCPostWordViewController.h"
#import "ZYCPlaceholderTextView.h"
#import "ZYCAddTagToolbar.h"
@interface ZYCPostWordViewController ()<UITextViewDelegate>
/** 文本输入控件 */
@property(nonatomic,weak)ZYCPlaceholderTextView *textView;
/** 工具条 */
@property(nonatomic,weak)ZYCAddTagToolbar *toolbar;
@end

@implementation ZYCPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpTextView];
    
    [self setUpToobar];
}
- (void)setUpToobar
{
    
    ZYCAddTagToolbar *toolbar = [ZYCAddTagToolbar viewFromXib];
    toolbar.width = self.view.width;
    toolbar.y = self.view.height-toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
    [ZYCNoteCenter addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
/**
 *监听键盘的弹出和隐藏
 */
- (void)KeyboardWillChangeFrame:(NSNotification *)note
{
    //键盘最终的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, keyboardFrame.origin.y - ZYCScreenH);
    }];
    
}
- (void)setUpTextView
{
   
    ZYCPlaceholderTextView *textView = [[ZYCPlaceholderTextView alloc]init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"发好玩儿的段子发好玩儿的段子发好玩儿的段子发好玩儿的段子发好玩儿的段子发好玩儿的段子发好玩儿的段子发好玩儿的段子发好玩儿的段子发好玩儿的段子发好玩儿的段子";
    textView.delegate = self;
    
//    textView.width = 230;
    [self.view addSubview:textView];
    
    
    self.textView = textView;
}
//因为viewDidLoad只加载一次
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //先退出之前的键盘
    [self.view endEditing:YES];
    //再调出新键盘
    [self.textView becomeFirstResponder];
    
}
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
    
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
/*
 UITextField *textField默认的情况
 1.只能显示一行文字
 2.有占位文字
 
 UITextView *textView默认的情况
 2.能显示任意行文字
 2.没有占位文字
 
 文本输入控件,最终希望拥有的功能
 1.能显示任意行文字
 2.有占位文字
 
 最终的方案:
 1.继承自UITextView
 2.在UITextView能显示任意行文字的基础上,增加"有占位文字"的功能
 */
@end
