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


#define ZYCSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]
@interface ZYCRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 左边的类别数据 */
@property(nonatomic,strong)NSArray *categories;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
//右边的用户表格
@property (weak, nonatomic) IBOutlet UITableView *userTableView;


@end

@implementation ZYCRecommendViewController
static NSString *const ZYCCategoryId = @"category";
static NSString *const ZYCUserId = @"user";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self setUpTableView];
    
    //添加刷新控件
    [self setUpRefresh];
    
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
   
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //隐藏hud
        [SVProgressHUD dismiss];
        
        //服务器返回的json数据
        self.categories = [ZYCRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
    }];
    
}
/** 添加刷新控件 */
- (void)setUpRefresh
{
    
    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];

    
    self.userTableView.footer.hidden = YES;
    
}
#pragma mark - 加载用户数据
- (void)loadMoreUsers
{
    ZYCRecommendCategory *category = ZYCSelectedCategory;
    
    //发送请求给服务器，加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @([ZYCSelectedCategory id]);
    params[@"page"] = @"2";
    
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        ZYCLog(@"%@",responseObject[@"list"]);
        //字典数组->模型数组
        NSArray *users = [ZYCRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        //刷新右边的表格
        [self.userTableView reloadData];
        //让底部控件结束刷新
        [self.userTableView.footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZYCLog(@"%@",error);
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _categoryTableView){//左边的类别表格
    return self.categories.count;
        
    }else{//右边的用户表格
        //左边被选中的类别模型
//        ZYCRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        
        NSInteger count = [ZYCSelectedCategory users].count;
        
        //每次刷新右边数据时，都控制footer的显示或者隐藏
        self.userTableView.footer.hidden = (count == 0);
        
        return count;
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
    ZYCRecommendCategory *c = self.categories[indexPath.row];
   
    
    if (c.users.count) {
        
        //显示曾经的数据
        
        [self.userTableView reloadData];
        
    } else {
        
        //赶紧刷新表格，目的是：马上显示当前category的用户数据，不让用户看到上一个category的残留数据
        [self.userTableView reloadData];
        
      
            //发送请求给服务器，加载右侧的数据
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            params[@"a"] = @"list";
            params[@"c"] = @"subscribe";
            params[@"category_id"] = @(c.id);
            
            
            [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                ZYCLog(@"%@",responseObject[@"list"]);
                //字典数组->模型数组
                NSArray *users = [ZYCRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
                //添加到当前类别对应的用户数组中
                [c.users addObjectsFromArray:users];
                //刷新右边的表格
                [self.userTableView reloadData];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                ZYCLog(@"%@",error);
            }];

    
        
        
        
    }
        }

@end
