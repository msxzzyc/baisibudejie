//
//  ZYCPlaceholderTextView.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/7.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCPlaceholderTextView.h"
@interface ZYCPlaceholderTextView()

@property(nonatomic,weak)UILabel *placeholderLabel;
@end
@implementation ZYCPlaceholderTextView
- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        //添加一个用来显示占位文字的label
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.numberOfLines = 0;

        placeholderLabel.x = 3;
        placeholderLabel.y = 7;

        
        [self addSubview:placeholderLabel];
       _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        //垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
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
 *更新占位文字的尺寸
 */
- (void)updatePlaceholderLabelFrame
{
//    CGSize maxSize = CGSizeMake(ZYCScreenW - 2*self.placeholderLabel.x, MAXFLOAT);
//    self.placeholderLabel.size = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
}
- (void)layoutSubviews
{
    self.placeholderLabel.width = self.width - 2*self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
    
}
/**
 *监听文字改变
 */
- (void)textDidChange
{
//    [self setNeedsDisplay];
    //只要有文字，就隐藏占位文字label
    self.placeholderLabel.hidden = self.hasText;
    
}

/**
 *绘制占位文字
 */
//- (void)drawRect:(CGRect)rect {
//    
//    //如果有输入文字，直接返回，不绘制占位文字
////    if (self.text.length || self.attributedText.length) return;
//    if (self.hasText) return;
//   //处理rect
//    rect.origin.x = 4;
//    rect.origin.y = 7;
//    rect.size.width -= 2*rect.origin.x;
//    
//    //文字属性
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = self.font;
//    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
//    
//    [self.placeholder drawInRect:rect withAttributes:attrs];
//}
#pragma mark - 重写setter方法

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
//    [self setNeedsDisplay];
    
    self.placeholderLabel.textColor = placeholderColor;
    
    
}

- (void)setPlaceholder:(NSString *)placeholder
{
    
    _placeholder = [placeholder copy];
//    [self setNeedsDisplay];
    self.placeholderLabel.text = self.placeholder;
    
//    [self updatePlaceholderLabelFrame];
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font ];
    
//    [self setNeedsDisplay];
    self.placeholderLabel.font = font;
//    [self updatePlaceholderLabelFrame];
    [self setNeedsLayout];
}
- (void)setText:(NSString *)text
{
    [super setText:text];
//    [self setNeedsDisplay];
    [self textDidChange];
}
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
//    [self setNeedsDisplay];
    [self textDidChange];
}
@end
