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
#import "ZYCUser.h"

#import "ZYCCommentHeaderView.h"
#import "ZYCCommentCell.h"

#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MJExtension.h"
//static NSInteger const ZYCHeaderLabelTag  = 99;

static NSString *const ZYCCommentCellID = @"comment";
@interface ZYCCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论*/
@property(nonatomic,strong)NSArray *hotComments;

/** 最新评论*/
@property(nonatomic,strong)NSMutableArray *latestComments;

/** 保存帖子的top_cmt*/
@property(nonatomic,strong)ZYCComment *save_top_cmt;

/** 保存当前页码 */
@property(nonatomic,assign)NSInteger page;

///** manager*/
@property(nonatomic,strong)AFHTTPSessionManager *manager;

/** 请求参数 */
@property(nonatomic,strong)NSMutableDictionary *params;



@end

@implementation ZYCCommentViewController
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

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
    
    self.tableView.footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.footer.hidden = YES;
    
    
}

- (void)loadMoreComments
{
//    //结束之前所有的请求 (会调用被取消请求的failure block)
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //页数
    NSInteger page = self.page+1;
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    
    params[@"page"] = @(page);
    ZYCComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //不是最后一次请求
        if (self.params != params) return ;
        //字典转模型
        
        //最新评论
        NSArray *newComments = [ZYCComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.latestComments addObjectsFromArray:newComments];
        
        //页码
        self.page = page;
        //刷新数据
        [self.tableView reloadData];
       
//        ZYCLog(@"%@",responseObject[@"total"]);
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count == total) {//评论通过下拉刷新已全部加载完毕
            //            [self.tableView.footer noticeNoMoreData];
            self.tableView.footer.hidden = YES;
        }else {//结束刷新状态
            [self.tableView.footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //不是最后一次请求
        if (self.params != params) return ;
        
        [self.tableView.footer endRefreshing];
    }];
    
   
}


- (void)loadNewComments
{
    //结束之前所有的请求 (会调用被取消请求的failure block)
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //不是最后一次请求
        if (self.params != params) return ;
        //字典转模型
        //最热评论
        self.hotComments = [ZYCComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //最新评论
        self.latestComments = [ZYCComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //页码
        self.page = 1;
        //刷新数据
        [self.tableView reloadData];
        //结束刷新状态
        [self.tableView.header endRefreshing];
        
//        ZYCLog(@"%@",responseObject[@"total"]);
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count == total) {//评论通过下拉刷新已全部加载完毕
//            [self.tableView.footer noticeNoMoreData];
            self.tableView.footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //不是最后一次请求
        if (self.params != params) return ;
        
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
    
    //背景色
    self.tableView.backgroundColor = ZYCGlobalBG;
    //添加通知中心监听键盘frame变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYCCommentCell class]) bundle:nil] forCellReuseIdentifier:ZYCCommentCellID];
    //设置cell行高
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, ZYCTopicCellMargin, 0);


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
    
    //控制器销毁的同时，结束之前所有任务
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];
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
    
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}
#pragma mark - UIMenuController处理


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIMenuController * menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else{
        
        //被点击的cell
        ZYCCommentCell *cell = (ZYCCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        //1.cell要成为第一响应者(告诉menuController支持哪些操作，这些操作如何处理)
        [cell becomeFirstResponder];
        //2.显示menuController
        
        //targetRect:menuController需要指向的矩形框
        //tagetView:targetRect会以tagetView的左上角为坐标原点
        //    [menu setTargetRect:self.frame inView:self.superview];
        
        //添加menuItem（点击item默认会调用控制器的方法）
        UIMenuItem *ding = [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *reply = [[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(reply:)];
        UIMenuItem *report = [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(report:)];
        menu.menuItems = @[ding,reply,report];
        CGRect rect = CGRectMake(0, cell.height*0.5, cell.width, cell.height*0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
    
    
 
}


- (void)ding:(UIMenuController *)menu
{
    //拿到被顶的评论
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@",__func__,[self commentsInIndexPath:indexPath].content);
    
}
- (void)reply:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@",__func__,[self commentsInIndexPath:indexPath].content);
}
- (void)report:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@",__func__,[self commentsInIndexPath:indexPath].content);
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
    //刷新数据时适时隐藏尾部控件
    tableView.footer.hidden = (latestCount == 0);
    
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
    ZYCCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ZYCCommentCellID];

    cell.comment = [self commentsInIndexPath:indexPath];
    
    
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
