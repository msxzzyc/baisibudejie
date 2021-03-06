//
//  ZYCAddTagViewController.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/24.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYCAddTagViewController : UIViewController
/** 获取tags的block */
@property(nonatomic,copy)void(^tagsBlock)(NSArray *tags);
/** 所有的标签 */
@property(nonatomic,strong)NSArray *tags;
@end
