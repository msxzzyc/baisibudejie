//
//  ZYCMeViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/3/17.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCMeViewController.h"
#import "ZYCMeCell.h"
#import "ZYCMeFooterView.h"
#import "ZYCSettingViewController.h"
static NSString *ZYCMeId = @"me";

@interface ZYCMeViewController ()

@end

@implementation ZYCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpNav];
    
    [self setUpTableView];
    
    
}

- (void)setUpNav
{
    //设置导航栏标题
    self.navigationItem.title = @"我的";
    
    //设置导航栏右边按钮
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    
}

- (void)setUpTableView
{
    //设置背景色
    self.tableView.backgroundColor = ZYCGlobalBG;
    
    //注册cell
    [self.tableView registerClass:[ZYCMeCell class] forCellReuseIdentifier:ZYCMeId];
    //去分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = ZYCTopicCellMargin;
    
    //调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(ZYCTopicCellMargin - 35, 0, 0, 0);
    
    self.tableView.tableFooterView = [[ZYCMeFooterView alloc]init];
    
    
}
- (void)settingClick
{
    [self.navigationController pushViewController:[[ZYCSettingViewController alloc]initWithStyle:UITableViewStyleGrouped] animated:YES];
    
}

- (void)moonClick
{
    NSLog(@"%s",__func__);
    
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYCMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ZYCMeId];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"离线下载";
    }
    
    
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
