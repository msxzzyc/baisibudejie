//
//  ZYCCommentHeaderView.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/30.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYCCommentHeaderView : UITableViewHeaderFooterView
/** 文字数据 */
@property(nonatomic,copy)NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
