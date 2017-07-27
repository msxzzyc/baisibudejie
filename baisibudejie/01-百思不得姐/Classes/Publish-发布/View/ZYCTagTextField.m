//
//  ZYCTagTextField.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/27.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCTagTextField.h"

@implementation ZYCTagTextField
/**
 *也能在此方法中监听键盘的输入，比如换行等
 */
//- (void)insertText:(NSString *)text
//{
//    [super insertText:text];
//    ZYCLogFunc;
//    ZYCLog(@"%d",[text isEqualToString:@"\n"]);
//    
//}
- (void)deleteBackward
{
    
    !self.deleteBlock ? :_deleteBlock();
    [super deleteBackward];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
