//
//  ZYCWordViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/11.
//  Copyright © 2017年 wpzyc. All rights reserved.
// 

#import "ZYCTopicViewController.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "MJRefresh.h"

#import "ZYCTopic.h"
#import "ZYCComment.h"
#import "ZYCTopicCell.h"
#import "ZYCCommentViewController.h"
#import "ZYCNewViewController.h"
@interface ZYCTopicViewController ()
/** 帖子模型数组 */
@property(nonatomic,strong)NSMutableArray *topics;

/** 当前页码 */
@property(nonatomic,assign)NSInteger page;
/** 加载下一页时会传该参数 */
@property(nonatomic,copy)NSString *maxtime;
/** 上一次的请求参数 */
@property(nonatomic,strong)NSDictionary *params;

/** 被点击控制器的index */
@property(nonatomic,assign)NSInteger lastSelectedIndex;
@end

@implementation ZYCTopicViewController


- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化表格
    [self setUpTableView];
    
    //添加刷新控件
    [self setUpRefresh];
    
    
}
//初始化表格
static NSString *const ZYCTopicCellID = @"topic";
- (void)setUpTableView
{
    //    设置内边距
    CGFloat top = ZYCTitlesViewY + ZYCTitlesViewH;
    CGFloat bottom = self.view.height - self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //设置分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYCTopicCell class]) bundle:nil] forCellReuseIdentifier:ZYCTopicCellID];
    
    //监听tabBar点击的通知
    [ZYCNoteCenter addObserver:self selector:@selector(tabBarSelect) name:ZYCDidSelectNotification object:nil];
}

- (void)tabBarSelect
{
    //如果是连续点击两次精华，直接刷新
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex &&
//        self.tabBarController.selectedViewController == self.navigationController &&
        self.view.isShowingOnKeyWindow) {
        [self.tableView.header beginRefreshing];
    }
    //记录这一次选中的索引
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}

- (void)setUpRefresh
{
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //自动改变透明度
    self.tableView.header.autoChangeAlpha = YES;
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}
#pragma mark - a参数
- (NSString *)a
{
    
    return [self.parentViewController isKindOfClass:[ZYCNewViewController class]] ? @"newlist" : @"list";
}

#pragma mark - 数据处理
/**
 *加载更多的帖子数据 上拉刷新
 */
- (void)loadMoreTopics
{
    //先结束下拉刷新
    [self.tableView.header endRefreshing];
    
    //    self.page++;
    //参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"a"] = [self a];
    parames[@"c"] = @"data";
    parames[@"type"] = @(self.type);
    //    parames[@"page"] = @(self.page);
    NSInteger page = self.page + 1;
    parames[@"page"] = @(page);
    parames[@"maxtime"] = self.maxtime;
    
    self.params = parames;
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parames success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        
        
        if (self.params != parames) return ;
        
        ZYCLog(@"%@",responseObject);
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //        [responseObject writeToFile:@"/Users/zyc/Desktop/未命名文件夹/duanzi.plist" atomically:YES];
        //字典转模型
        NSArray *newTopics = [ZYCTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        

        
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.footer endRefreshing];
        
        self.page = page;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != parames) return ;
        ZYCLog(@"%@",error);
        //        恢复页码
        //        self.page--;
        
        [self.tableView.footer endRefreshing];
    }];
}

//先下拉刷新，再上拉刷新第5页数据出现问题

//下拉刷新成功回来：只有第一页数据，page = 0；
//上拉刷新后成功回来：最前面那页+第5页数据

//解决方案：限制同时进行上拉下拉两种刷新
/**
 *加载新的帖子数据 下拉刷新
 */
- (void)loadNewTopics
{
    //先结束上拉刷新
    [self.tableView.footer endRefreshing];
    
    //参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"a"] = [self a];
    parames[@"c"] = @"data";
    parames[@"type"] = @(self.type);
    
    self.params = parames;
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parames success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        
        
        
        if (self.params != parames) return ;
        
//        ZYCLog(@"%@",responseObject);
        
        //        [responseObject writeToFile:@"/Users/zyc/Desktop/未命名文件夹/duanzi.plist" atomically:YES];
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型 (下拉刷新直接覆盖数据)
        self.topics = [ZYCTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.header endRefreshing];
        //加载成功后清空页码
        self.page = 0;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != parames) return ;
        ZYCLog(@"%@",error);
        [self.tableView.header endRefreshing];
    }];

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.footer.hidden = self.topics.count == 0;
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYCTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ZYCTopicCellID];
    cell.topic = self.topics[indexPath.row];

    return cell;
}
#pragma mark - 代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //取出模型数据
    ZYCTopic *topic = self.topics[indexPath.row];
    
    return topic.cellHeight;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYCCommentViewController *cmtVc = [[ZYCCommentViewController alloc]init];
    cmtVc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:cmtVc animated:YES];
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
