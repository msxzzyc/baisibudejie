//
//  ZYCTextField.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/6/8.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCTextField.h"
#import <objc/runtime.h>

static NSString *const ZYCPlaceholderColorKeyPath = @"_placeholderLabel.textColor";
@implementation ZYCTextField


//-(void)drawPlaceholderInRect:(CGRect)rect
//{
//    [self.placeholder drawInRect:CGRectMake(0, 15, self.width, 25) withAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : self.font }];
//    
//}

/**
 运行时（Runtime）：
 *苹果官方的一套c语言库
 *能做很多底层操作（比如访问隐藏的一些成员变量\成员方法......）
 */
+ (void)initialize
{
    unsigned int count = 0;
    //拷贝出所有成员变量列表
    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
    
    for (int i = 0; i < count; i++) {
        //取出属性
        //数组名就是指向数组首元素的指针（ivars）
        objc_property_t property = properties[i];
        
        //打印属性名字/类型
        ZYCLog(@"%s ------ %s",property_getName(property),property_getAttributes(property));
    }
    
    //释放内存
    free(properties);
}

- (void)getIvars
{
    unsigned int count = 0;
    //拷贝出所有成员变量列表
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    for (int i = 0; i < count; i++) {
        //取出成员变量
        //数组名就是指向数组首元素的指针（ivars）
        //        Ivar ivar = *(ivars + i);
        Ivar ivar = ivars[i];
        //打印成员变量名字
        ZYCLog(@"%s",ivar_getName(ivar));
    }
    
    //释放内存
    free(ivars);
    
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
//    UILabel *placeholderLabel = [self valueForKeyPath:@"_placeholderLabel"];
//    
//    placeholderLabel.textColor = [UIColor redColor];
    
    //设置光标颜色和占位文字颜色一致
    self.tintColor = self.textColor;
    //不成为第一响应者
    [self resignFirstResponder];
}
/**
 *当前文本框聚焦时会调用
 */
- (BOOL)becomeFirstResponder
{
    //修改占位文字颜色
    [self setValue:[UIColor whiteColor] forKeyPath:ZYCPlaceholderColorKeyPath];
    return [super becomeFirstResponder];
    
}
/**
 *当前文本框失去焦点时会调用
 */
- (BOOL)resignFirstResponder
{
    //修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:ZYCPlaceholderColorKeyPath];
    return [super resignFirstResponder];
    
    
}

//- (void)setPlaceholderColor:(UIColor *)placeholderColor
//{
//    
//    _placeholderColor = placeholderColor;
//    
//    //修改占位文字颜色
//    [self setValue:placeholderColor forKeyPath:ZYCPlaceholderColorKeyPath];
//    
//}

@end
