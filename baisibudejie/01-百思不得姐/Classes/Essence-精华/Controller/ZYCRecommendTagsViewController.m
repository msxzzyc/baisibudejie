//
//  ZYCRecommendTagsViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/5.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCRecommendTagsViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"


#import "ZYCRecommendTag.h"
#import "ZYCRecommendTagCell.h"

@interface ZYCRecommendTagsViewController ()

@property(nonatomic,strong)NSArray *recommendTags;
@end

@implementation ZYCRecommendTagsViewController
static NSString *const ZYCTagId = @"tag";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    //初始化控制器
    [self setUpTableView];
    
    
    //发送请求
    [self loadTags];
}
//初始化控制器
- (void)setUpTableView
{
    self.title =@"推荐标签";
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYCRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:ZYCTagId];
    self.view.backgroundColor = ZYCGlobalBG;
    
    self.tableView.rowHeight = 70;
   
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
}
//发送请求
- (void)loadTags
{
    //显示遮盖
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
   
    
    //发请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //隐藏遮盖
        [SVProgressHUD dismiss];
        
        NSLog(@"%@",responseObject);
        
        self.recommendTags = [ZYCRecommendTag objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //显示错误提示信息
        [SVProgressHUD showErrorWithStatus:@"推荐标签显示错误！"];
    }];
    
    
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.recommendTags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZYCRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ZYCTagId forIndexPath:indexPath];
    
    cell.recommendTag = self.recommendTags[indexPath.row];
    
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
