//
//  ZYCTopic.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/12.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCTopic.h"

#import "ZYCComment.h"
#import "ZYCUser.h"
#import "MJExtension.h"

@implementation ZYCTopic



//加readonly使cellHeight没有set方法，再加上重写了其get方法，就不会生成cellHeight的成员变量
{

    CGFloat _cellHeight;
   

}

//
+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{ @"smallImage":@"image0",
              @"largeImage":@"image1",
              @"middleImage":@"image3",
              @"ID":@"id",
              @"top_cmt":@"top_cmt[0]"//直接将top_cmt数组中的第0个字典转成模型属性
//              @"qzone_uid":@"top_cmt[0].user.qzone_uid"
              };
    
}

//数组中字典转模型类
+ (NSDictionary *)objectClassInArray
{
//    return @{@"top_cmt":[ZYCComment class]};
    return @{@"top_cmt":@"ZYCComment"};
    
    
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
        
        if (self.type == ZYCTopicTypePicture)
        {//图片帖子
            
            //图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            //图片显示出来的高度
            CGFloat pictureH = pictureW * self.height/self.width;
            //判断图片高度是否超出最大高度
            if (pictureH >= ZYCTopicPictureMaxH) {//图片高度过长
                
                pictureH = ZYCTopicPictureBreakH;
                self.isBigPicture = YES;
            }
            
            //计算图片控件的frame
            CGFloat pictureX = ZYCTopicCellMargin;
            CGFloat pictureY = ZYCTopicCellTextY + textH + ZYCTopicCellMargin;
            _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + ZYCTopicCellMargin;
            
        }else if (self.type == ZYCTopicTypeVoice)//声音帖子
        {
            CGFloat voiceX = ZYCTopicCellMargin;
            CGFloat voiceY = ZYCTopicCellTextY + textH + ZYCTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW *self.height/self.width;
            
            _voiceViewFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + ZYCTopicCellMargin;
        
            
        }else if (self.type == ZYCTopicTypeVideo)//视频帖子
        {
            CGFloat videoX = ZYCTopicCellMargin;
            CGFloat videoY = ZYCTopicCellTextY + textH + ZYCTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW *self.height/self.width;
            
            _videoViewFrame = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + ZYCTopicCellMargin;
            
            
        }else{
            _cellHeight += ZYCTopicCellMargin;
        }
        
        //如果有最热评论，计算最热评论view高度
        
        if (self.top_cmt) {
           
            NSString *content = [NSString stringWithFormat:@"%@ : %@",self.top_cmt.user.username,self.top_cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += ZYCTopicCellTopCmtTitleH + contentH + ZYCTopicCellMargin;
        }
        
        
        //加上底部工具条的高度
        _cellHeight += ZYCTopicCellBottomBarH + ZYCTopicCellMargin;
        
//        ZYCLog(@"%@",self.qzone_uid);
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
