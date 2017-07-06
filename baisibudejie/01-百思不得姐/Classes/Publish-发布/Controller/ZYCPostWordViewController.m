//
//  ZYCPostWordViewController.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/6.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCPostWordViewController.h"

@interface ZYCPostWordViewController ()

@end

@implementation ZYCPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"发表文字";
//    self.navigationItem.titleView = 
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
}

- (void)cancel
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    ZYCLogFunc;
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
