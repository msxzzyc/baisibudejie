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
#import "ZYCComment.h"
#import "ZYCCommentHeaderView.h"

#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MJExtension.h"
//static NSInteger const ZYCHeaderLabelTag  = 99;
@interface ZYCCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论*/
@property(nonatomic,strong)NSArray *hotComments;

/** 最新评论*/
@property(nonatomic,strong)NSMutableArray *latestComments;

/** 保存帖子的top_cmt*/
@property(nonatomic,strong)ZYCComment *save_top_cmt;

@end

@implementation ZYCCommentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBasic];
    
    [self setUpHeader];
    
    [self setRefresh];
    
}

- (void)setRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    
    [self.tableView.header beginRefreshing];
    
}

- (void)loadNewComments
{
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //字典转模型
        //最热评论
        self.hotComments = [ZYCComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //最新评论
        self.latestComments = [ZYCComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        [self.tableView.header endRefreshing];
    }];
    
}

//用view包装header，因为header尺寸很难直接设置，也为防止直接设置cell宽高带来setframe连锁变化
- (void)setUpHeader
{
    // 创建header
    UIView *header = [[UIView alloc]init];
    //清空top_cmt
    if (self.topic.top_cmt) {
        self.save_top_cmt = self.topic.top_cmt;
        
        self.topic.top_cmt = nil;
        
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
   //添加cell
    ZYCTopicCell *cell = [ZYCTopicCell cell];
    
    cell.topic = self.topic;
    //从xib中加载的cell必须重新设置宽高
//    cell.size = CGSizeMake(ZYCScreenW,self.topic.cellHeight);
    cell.frame = CGRectMake(0, 0, ZYCScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    
    //header的高度（加的是顶部间隙高度）
    header.height = self.topic.cellHeight + ZYCTopicCellMargin;
//    header.backgroundColor = [UIColor redColor];
    //设置header
    self.tableView.tableHeaderView = header;
    
}
- (void)setUpBasic
{
    self.title = @"评论";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:self action:nil];
    
    self.tableView.backgroundColor = ZYCGlobalBG;
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
    
    //恢复帖子的top_cmt
    if (self.topic.top_cmt) {
        
        
        self.topic.top_cmt = self.save_top_cmt;
        
        //通过清零重算恢复的模型中的cellHeight
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 返回第section组的所有评论数组
 */
- (NSArray *)commentsInSection:(NSInteger)section
{
    
    
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
    
}
- (ZYCComment *)commentsInIndexPath:(NSIndexPath *)indexPath
{
    
    return [self commentsInSection:indexPath.section] [indexPath.row];
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
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (hotCount) return 2; //有 最热评论 + 最新评论 2组
    if (latestCount) return 1;//有 最新评论 1组
    return 0;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (section == 0) {
//        if (hotCount) return hotCount;
//        if (latestCount) return latestCount;
        
        return  hotCount ? hotCount : latestCount;
}
    //非第0组
    return latestCount;
    
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSInteger hotCount = self.hotComments.count;
//
//    if (section == 0) {
//        return hotCount ? @"最热评论" : @"最新评论";
//    }
//    return @"最新评论";
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    //创建头部
//    UIView *header = [[UIView alloc]init];
//    header.backgroundColor = ZYCGlobalBG;
//
//    //创建label
//    UILabel *label = [[UILabel alloc]init];
//    label.textColor = ZYCRGBColor(67, 67, 67);
//    //label背景色默认为clearcolor，所以此时显示全局背景色
//    label.width = 200;
//    label.x = ZYCTopicCellMargin;
//    //随父控件自动调整高度
//    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//
//    [header addSubview:label];
//    //设置文字
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        label.text = hotCount ? @"最热评论" : @"最新评论";
//    }else{
//        label.text = @"最新评论";
//    }
//
//    
//    return header;
//}

//自定义viewForHeaderInSection,必须重写heightForHeaderInSection方法，否则方法不会调用
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
    
}



//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    static NSString *ID = @"header";
// //先从缓冲池中找header
//    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
//    UILabel *label = nil;
//    
//    if (header == nil) {//缓冲池中没有，自己创建
//        header = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:ID];
//        header.contentView.backgroundColor = ZYCGlobalBG;
//        //创建label
//        label = [[UILabel alloc]init];
//        label.textColor = ZYCRGBColor(67, 67, 67);
//        //label背景色默认为clearcolor，所以此时显示全局背景色
//        label.width = 200;
//        label.x = ZYCTopicCellMargin;
//        //    label.y = 0;
//        //随父控件自动调整高度
//        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//
//        label.tag = ZYCHeaderLabelTag;
//
//        [header.contentView addSubview:label];
//      
//    } else {//从缓冲池中取出来
//        label = [header viewWithTag:ZYCHeaderLabelTag];
//    }
//    
//    //设置文字
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        label.text = hotCount ? @"最热评论" : @"最新评论";
//    }else{
//        label.text = @"最新评论";
//    }
//
//    
//    return header;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     ZYCCommentHeaderView *header = [ZYCCommentHeaderView headerViewWithTableView:tableView];
    
    //设置文字
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
       header.title = hotCount ? @"最热评论" : @"最新评论";
    }else{
       header.title = @"最新评论";
    }
    
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    
    
    ZYCComment *comment = [self commentsInIndexPath:indexPath];
    cell.textLabel.text = comment.content;
    return cell;
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
