//
//  ZYCRecommendViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/5/31.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCRecommendViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "MJRefresh.h"

#import "ZYCRecommendCategoryCell.h"

#import "MJExtension.h"
#import "ZYCRecommendCategory.h"

#import "ZYCRecommendUserCell.h"

#import "ZYCRecommendUser.h"

//左边被选中的类别模型
#define ZYCSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]
@interface ZYCRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 左边的类别数据 */
@property(nonatomic,strong)NSArray *categories;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
//右边的用户表格
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** 请求参数 */
@property(nonatomic,strong)NSMutableDictionary *params;
/** AFN请求管理者 */
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@end

@implementation ZYCRecommendViewController
static NSString *const ZYCCategoryId = @"category";
static NSString *const ZYCUserId = @"user";


- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self setUpTableView];
    
    //添加刷新控件
    [self setUpRefresh];
    
    //加载左侧的类别数据
    [self loadCategories];
}
/** 
 *加载左侧的类别数据
 */
- (void)loadCategories
{
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    
    //发送请求
    [self.manager  GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //隐藏hud
        [SVProgressHUD dismiss];
        
        //服务器返回的json数据
        self.categories = [ZYCRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        [self.userTableView.header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
    }];

}
/** 添加刷新控件 */
- (void)setUpRefresh
{
    self.userTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];

}


#pragma mark - 加载用户数据

- (void)loadNewUsers
{
    
    ZYCRecommendCategory *category = ZYCSelectedCategory;
    //设置当前页码为1
    category.currentPage = 1;
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(category.currentPage);
    self.params = params;
    
    //发送请求给服务器，加载右侧的数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
       
        ZYCLog(@"%@",responseObject);
        //字典数组->模型数组
        NSArray *users = [ZYCRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //清除所有旧数据
        [category.users removeAllObjects];
        
        //添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        // 保存总数
        category.total = [responseObject[@"total"] integerValue];
        
        //不是最后一次请求
        if (self.params != params) return ;
        
        //刷新右边的表格
        [self.userTableView reloadData];
        //头部控件结束刷新
         [self.userTableView.header endRefreshing];
        
        //监测footer的状态
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (self.params != params) return ;
        
        //失败提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        //结束刷新
        [self.userTableView.header endRefreshing];
        
    }];
    
    
    
    
}

- (void)loadMoreUsers
{
    
    
    ZYCRecommendCategory *category = ZYCSelectedCategory;
    
    //发送请求给服务器，加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @([ZYCSelectedCategory id]);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (self.params != params) return ;
        
        ZYCLog(@"%@",responseObject[@"list"]);
        //字典数组->模型数组
        NSArray *users = [ZYCRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        //不是最后一次请求
        if (self.params != params) return ;
        //刷新右边的表格
        [self.userTableView reloadData];
        
        //监测footer的状态
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (self.params != params) return ;
        
        //失败提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        //结束刷新
        [self.userTableView.header endRefreshing];
    }];

    
}
/** 控件的初始化 */
- (void)setUpTableView
{
    //注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYCRecommendCategoryCell class]) bundle:nil]  forCellReuseIdentifier:ZYCCategoryId];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYCRecommendUserCell class]) bundle:nil]  forCellReuseIdentifier:ZYCUserId];
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    //设置标题
    self.title = @"推荐关注";
    
    //设置背景色
    self.view.backgroundColor = ZYCGlobalBG;
}

/** 时刻监测footer的状态 */
- (void)checkFooterState
{
    ZYCRecommendCategory *category = ZYCSelectedCategory;
    //每次刷新右边数据时，都控制footer的显示或者隐藏
    self.userTableView.footer.hidden = (category.users.count == 0);
    
    //让底部控件结束刷新
    if (category.users.count == category.total) {//全部数据已经加载完毕
        
        [self.userTableView.footer noticeNoMoreData];
    }else{//还没有加载完毕
        
        [self.userTableView.footer endRefreshing];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _categoryTableView){//左边的类别表格
        
    return self.categories.count;
        
    }else{//右边的用户表格
        
        //监测footer的状态
        [self checkFooterState];
        return [ZYCSelectedCategory users].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _categoryTableView){//左边的类别表格
        ZYCRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ZYCCategoryId];
        
        cell.category = self.categories[indexPath.row];
        return cell;
        
    }else{//右边的用户表格
        ZYCRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:ZYCUserId];
        
        //左边被选中的类别模型
//        ZYCRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        
        cell.user = [ZYCSelectedCategory users][indexPath.row];
        
        return cell;
    }
    
    
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //结束刷新
    [self.userTableView.header endRefreshing];
    [self.userTableView.footer endRefreshing];
    
    ZYCRecommendCategory *c = self.categories[indexPath.row];
   
    
    if (c.users.count) {
        
        //显示曾经的数据
        
        [self.userTableView reloadData];
        
    } else {
        
        //赶紧刷新表格，目的是：马上显示当前category的用户数据，不让用户看到上一个category的残留数据
        [self.userTableView reloadData];
        
        //进入下拉刷新状态
        [self.userTableView.header beginRefreshing];
        
    }
    
}

#pragma mark - 控制器的销毁
- (void)dealloc
{
    //停止所有操作
    [self.manager.operationQueue cancelAllOperations];
    
}


    


@end
