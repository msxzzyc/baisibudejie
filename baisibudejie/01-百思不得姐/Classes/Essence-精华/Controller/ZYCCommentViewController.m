//
//  ZYCCommentViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/29.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCCommentViewController.h"
#import "ZYCTopicCell.h"
#import "ZYCTopic.h"

@interface ZYCCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation ZYCCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBasic];
    
    [self setUpHeader];
    
}
//用view包装header，防止直接设置cell宽高带来setframe连锁变化
- (void)setUpHeader
{
    // 创建header
    UIView *header = [[UIView alloc]init];
   //添加cell
    ZYCTopicCell *cell = [ZYCTopicCell cell];
    
    cell.topic = self.topic;
    //从xib中加载的cell必须重新设置宽高
    cell.size = CGSizeMake(ZYCScreenW,self.topic.cellHeight);
    
    [header addSubview:cell];
    
    //header的高度
    header.height = self.topic.cellHeight + ZYCTopicCellMargin;
    //设置header
    self.tableView.tableHeaderView = header;
    
}
- (void)setUpBasic
{
    self.title = @"评论";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:self action:nil];
    
    //添加通知中心监听键盘frame变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)KeyboardWillChangeFrame:(NSNotification *)note
{
//键盘显示/隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //修改底部约束
    self.bottomSpace.constant = ZYCScreenH - frame.origin.y;
    //获取动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc
{
    //清除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
   
    //退出键盘
    [self.view endEditing:YES];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd - %zd",indexPath.section,indexPath.row];
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"评论";
    
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
