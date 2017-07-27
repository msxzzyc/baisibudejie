//
//  ZYCTagTextField.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/27.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYCTagTextField : UITextField
/** 按了删除键后的回调 */
@property(nonatomic,copy)void(^deleteBlock)();
@end
