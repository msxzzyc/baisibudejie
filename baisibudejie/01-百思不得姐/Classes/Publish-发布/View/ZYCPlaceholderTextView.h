//
//  ZYCPlaceholderTextView.h
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/7.
//  Copyright © 2017年 wpzyc. All rights reserved.
//  拥有占位文字控件的textView控件


#import <UIKit/UIKit.h>

@interface ZYCPlaceholderTextView : UITextView
/** 占位文字 */
@property(nonatomic,copy)NSString *placeholder;

/** 占位文字颜色 */
@property(nonatomic,strong)UIColor *placeholderColor;
@end
