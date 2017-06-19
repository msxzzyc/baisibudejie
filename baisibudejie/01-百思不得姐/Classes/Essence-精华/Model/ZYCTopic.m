//
//  ZYCTopic.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/12.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCTopic.h"
//#import "MJExtension.h"

@implementation ZYCTopic



//加readonly使cellHeight没有set方法，再加上重写了其get方法，就不会生成cellHeight的成员变量
{

    CGFloat _cellHeight;
    CGRect _pictureViewFrame;

}

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{ @"smallImage":@"image0",
              @"largeImage":@"image1",
              @"middleImage":@"image3"
              };
    
}
- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        ZYCLogFunc;
        //文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4*ZYCTopicCellMargin, MAXFLOAT);
        //    CGFloat textH = [topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize].height;
        //计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil].size.height;
        //cell的高度
        //文字部分的高度
        _cellHeight = ZYCTopicCellTextY + textH + ZYCTopicCellMargin;
        
        if (self.type == ZYCTopicTypePicture) {//图片帖子
            
            //图片显示出来的宽度
            CGFloat pictureW = 335;
            //图片显示出来的高度
            CGFloat pictureH = pictureW * self.height/self.width;
            
            //计算图片控件的frame
            CGFloat pictureX = ZYCTopicCellMargin;
            CGFloat pictureY = ZYCTopicCellTextY + textH + ZYCTopicCellMargin;
            _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + ZYCTopicCellMargin;
        }
        //底部工具条的高度
        _cellHeight += ZYCTopicCellBottomBarH + ZYCTopicCellMargin;
    }
    return _cellHeight;
}

- (NSString *)create_time
{
    //日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //设置日期格式
    fmt.dateFormat = @"yyyy-MM-dd-HH-mm-ss";
    //发帖时间
    NSDate *create = [fmt dateFromString:_create_time];
    //当前时间
    NSDate *now = [NSDate date];
    if ([create isThisYear]) {//今年
        NSDateComponents *createCmp = [now deltaFrom:create];
        if ([create isToday]){//今天
            
            if (createCmp.hour >= 1) {//时间差距>=1小时
                return [NSString stringWithFormat:@"%zd小时前",createCmp.hour];
            }else if (createCmp.minute>=1){// 1小时>时间差距>=
                return [NSString stringWithFormat:@"%zd分钟前",createCmp.minute];
                
                
            }else{//1分钟>时间差距
                return @"刚刚";
            }
            
        }else if ([create isYestoday]){//昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }else{//其他
            
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
        
    }else{//非今年
        return _create_time;
        
    }

    
}
@end
