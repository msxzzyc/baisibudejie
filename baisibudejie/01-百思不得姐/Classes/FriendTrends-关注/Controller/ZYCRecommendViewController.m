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
@interface ZYCRecommendViewController ()

@end

@implementation ZYCRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
    }];
    
}





@end
