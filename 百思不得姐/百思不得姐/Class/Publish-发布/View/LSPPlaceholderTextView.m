//
//  LSPPlaceholderTextView.m
//  百思不得姐
//
//  Created by mac on 16-4-12.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPPlaceholderTextView.h"

@interface LSPPlaceholderTextView()
@property (nonatomic,weak) UILabel *placeholderLabel;

@end
@implementation LSPPlaceholderTextView

- (UILabel *)placeholderLabel
{
    if (!_placeholder) {
        //添加一个用来显示占位文字的Label控件
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 3;
        placeholderLabel.y = 7;
       // placeholderLabel.hidden = YES;
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;

    }
    return _placeholderLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        //默认的的字体
        self.font = [UIFont systemFontOfSize:15];
        //默认的文字颜色
        self.placeholderColor = [UIColor grayColor];
        //监听文字改变
        [LSPNotiCenter addObserver:self selector:@selector(textViewTextDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.width = self.frame.size.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    //[self setNeedsDisplay];
    self.placeholderLabel.textColor = placeholderColor;
    
    
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
    
  //  [self updatePlaceholderLabelSize];
    [self setNeedsLayout];
}
/**
 *  更新占位文字控件的尺寸
 */
/*
- (void)updatePlaceholderLabelSize
{
    CGSize maxSize = CGSizeMake(LSPScreenW - 2 * self.placeholderLabel.x, MAXFLOAT);
    
    self.placeholderLabel.size = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;

}
 */
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    
    // [self updatePlaceholderLabelSize];
     [self setNeedsLayout];
 
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textViewTextDidChange];
   // [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self textViewTextDidChange];
    //[self setNeedsDisplay];
}
/**
 *  监听文字改变的通知
 */
- (void)textViewTextDidChange
{
    //有文字显示，就隐藏占位文字控件
    self.placeholderLabel.hidden = self.hasText;
   // [self setNeedsDisplay];
}
- (void)dealloc
{
    [LSPNotiCenter removeObserver:self];
}
/*
- (void)drawRect:(CGRect)rect {
    //如果有文字,就直接返回，不再画占位的文字了
   // if (self.text.length || self.attributedText.length) return;
    if(self.hasText) return;
    
   //处理rect
    rect.origin.x = 3;
    rect.origin.y = 7;
    rect.size.width -= rect.origin.x * 2;
    //处理字体
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    [self.placeholder drawInRect:rect withAttributes:attrs];
}
*/

@end
