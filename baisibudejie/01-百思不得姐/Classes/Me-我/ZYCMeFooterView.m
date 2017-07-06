//
//  ZYCMeFooterView.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/5.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCMeFooterView.h"
#import "AFNetworking.h"
#import "ZYCSquare.h"
#import "MJExtension.h"

#import "ZYCWebViewController.h"
#import "ZYCSquareButton.h"
@implementation ZYCMeFooterView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        //参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";

        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
           
            NSArray *squares = [ZYCSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            //创建方块
            [self createSquares:squares];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
        }];
    }
    return self;
}

- (void)createSquares:(NSArray *)squares
{
    //一行最多四列
    int maxCols = 4;
 
    //宽度和高度
    CGFloat buttonW = ZYCScreenW/maxCols;
    CGFloat buttonH = buttonW;
    
    
    for (int i = 0; i < squares.count; i++) {
        //创建按钮
        ZYCSquareButton *button = [ZYCSquareButton buttonWithType:UIButtonTypeCustom];
        //传递模型
        button.square = squares[i];
       
        //监听点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        //计算frame
        int col = i%maxCols;
        int row = i/maxCols;
        button.width = buttonW;
        button.height = buttonH;
        button.x =  col*buttonW;
        button.y =  row*buttonH;
        //计算footer高度
        self.height = CGRectGetMaxY(button.frame);
    }
    
    
    //总行数
//    NSUInteger *rows = squares.count/maxCols;
//    if (squares.count % maxCols != 0) {//不能整除，+1
//        rows++;
//    }
    
//    //公式 总页数== （总个数+每页的最大数 - 1）/每页最大数
//    NSUInteger *rows = (squares.count + maxCols - 1)/maxCols;
//    
//    //计算footer高度
//    self.height = (int)rows * buttonH;
    //重绘
    [self setNeedsDisplay];
    
}
- (void)buttonClick:(ZYCSquareButton *)button
{
    if (![button.square.url hasPrefix:@"http"]) return;
    
    //拿到导航控制器
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
    
    ZYCWebViewController *web = [[ZYCWebViewController alloc]init];
    web.title = button.square.name;
    web.url = button.square.url;
    [nav pushViewController:web animated:YES];
}

- (void)drawRect:(CGRect)rect
{
//    [[UIImage imageNamed:@"mainCellBackground"]drawInRect:rect];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
