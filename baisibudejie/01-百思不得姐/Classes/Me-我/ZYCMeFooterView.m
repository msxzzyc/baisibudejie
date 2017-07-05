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
#import "UIButton+WebCache.h"

#import "ZYCSquareButton.h"
@implementation ZYCMeFooterView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
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
        ZYCSquareButton *button = [ZYCSquareButton buttonWithType:UIButtonTypeCustom];
        
        ZYCSquare *square = squares[i];
        [button setTitle:square.name forState:UIControlStateNormal];
        //用sdImage给按钮设置image
        [button sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
        [self addSubview:button];
        
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

- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"mainCellBackground"]drawInRect:rect];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
