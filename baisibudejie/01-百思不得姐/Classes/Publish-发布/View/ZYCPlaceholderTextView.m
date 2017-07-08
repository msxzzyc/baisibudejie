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
        self.font = [UIFont systemFontOfSize:15];
        
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
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    [self.placeholder drawInRect:rect withAttributes:attrs];
}


@end
