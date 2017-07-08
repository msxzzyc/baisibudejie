//
//  ZYCPlaceholderTextView.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/7.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCPlaceholderTextView.h"

@implementation ZYCPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        //默认字体
        self.font = [UIFont systemFontOfSize:15];
        //默认占位文字颜色
        self.placeholderColor = [UIColor grayColor];
        //监听文字改变
        [ZYCNoteCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}
- (void)dealloc
{
    [ZYCNoteCenter removeObserver:self];
}
/**
 *监听文字改变
 */
- (void)textDidChange
{
    [self setNeedsDisplay];
    
}

/**
 *绘制占位文字
 */
- (void)drawRect:(CGRect)rect {
    
    //如果有输入文字，直接返回，不绘制占位文字
//    if (self.text.length || self.attributedText.length) return;
    if (self.hasText) return;
   //处理rect
    rect.origin.x = 4;
    rect.origin.y = 7;
    rect.size.width -= 2*rect.origin.x;
    
    //文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    [self.placeholder drawInRect:rect withAttributes:attrs];
}
#pragma mark - 重写setter方法

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
    
}

- (void)setPlaceholder:(NSString *)placeholder
{
    
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font ];
    
    [self setNeedsDisplay];
}
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
@end
