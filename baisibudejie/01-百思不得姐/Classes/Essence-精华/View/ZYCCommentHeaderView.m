//
//  ZYCCommentHeaderView.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/30.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCCommentHeaderView.h"
@interface ZYCCommentHeaderView()
/** 文字标签*/
@property(nonatomic,weak)UILabel *label;
@end
@implementation ZYCCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    //先从缓冲池中找header
    ZYCCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (header == nil) {//缓冲池中没有，自己创建
        header = [[ZYCCommentHeaderView alloc]initWithReuseIdentifier:ID];
        
    }
    return header;
    
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIView *header = [[UITableViewHeaderFooterView alloc]init];
        self.backgroundColor = ZYCGlobalBG;
        //创建label
         UILabel *label = [[UILabel alloc]init];
        
        label.textColor = ZYCRGBColor(67, 67, 67);
        //label背景色默认为clearcolor，所以此时显示全局背景色
        label.width = 200;
        label.x = ZYCTopicCellMargin;
        //    label.y = 0;
        //随父控件自动调整高度
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        self.label = label;
        
        [self addSubview:label];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.label.text = title;
}

@end
