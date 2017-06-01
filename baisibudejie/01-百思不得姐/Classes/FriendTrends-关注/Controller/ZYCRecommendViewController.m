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

#import "ZYCRecommendCategoryCell.h"

#import "MJExtension.h"
#import "ZYCRecommendCategory.h"
@interface ZYCRecommendViewController ()<UITableViewDataSource,UITabBarDelegate>

/** 左边的类别数据 */
@property(nonatomic,strong)NSArray *categories;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@end

@implementation ZYCRecommendViewController
static NSString *const ZYCCategoryId = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYCRecommendCategoryCell class]) bundle:nil]  forCellReuseIdentifier:ZYCCategoryId];
    
    
    self.title = @"推荐关注";
    
    //设置背景色
    self.view.backgroundColor = ZYCGlobalBG;
    
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        ZYCLog(@"%@",responseObject);
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYCRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ZYCCategoryId];
    
    cell.category = self.categories[indexPath.row];
    return cell;
    
}



@end
