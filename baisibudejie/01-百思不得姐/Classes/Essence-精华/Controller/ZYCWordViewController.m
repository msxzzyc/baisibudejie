//
//  ZYCWordViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/11.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCWordViewController.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "MJRefresh.h"

#import "ZYCTopic.h"
@interface ZYCWordViewController ()
/** 帖子模型数组 */
@property(nonatomic,strong)NSMutableArray *topics;
/** 当前页码 */
@property(nonatomic,assign)NSInteger page;
/** 加载下一页时会传该参数 */
@property(nonatomic,assign)NSInteger maxtime;

@end

@implementation ZYCWordViewController

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加刷新控件
    [self setUpRefresh];
}

- (void)setUpRefresh
{
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //自动改变透明度
    self.tableView.header.autoChangeAlpha = YES;
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}
#pragma mark - 数据处理
/**
 *加载更多的帖子数据 上拉刷新
 */
- (void)loadMoreTopics
{

    self.page++;
    //参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"a"] = @"list";
    parames[@"c"] = @"data";
    parames[@"type"] = @"29";
    parames[@"page"] = @(self.page);
    parames[@"maxtime"] = @(self.maxtime);
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parames success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
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
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZYCLog(@"%@",error);
        [self.tableView.footer endRefreshing];
    }];
}
/**
 *加载新的帖子数据 下拉刷新
 */
- (void)loadNewTopics
{
    self.page = 0;
    //参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"a"] = @"list";
    parames[@"c"] = @"data";
    parames[@"type"] = @"29";

    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parames success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        
        ZYCLog(@"%@",responseObject);
        
        //        [responseObject writeToFile:@"/Users/zyc/Desktop/未命名文件夹/duanzi.plist" atomically:YES];
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型 (下拉刷新直接覆盖数据)
         self.topics = [ZYCTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZYCLog(@"%@",error);
        [self.tableView.header endRefreshing];
    }];

    
    
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        return cell;
    }
    
//    cell.textLabel.text = [NSString stringWithFormat:@"%@----%zd",[self class],indexPath.row];
    
    ZYCTopic *topic = self.topics[indexPath.row];
    ZYCLog(@"%@",topic.maxtime);
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    return cell;
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
