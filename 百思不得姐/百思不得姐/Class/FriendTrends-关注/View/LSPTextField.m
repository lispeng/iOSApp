//
//  LSPTextField.m
//  百思不得姐
//
//  Created by mac on 16-2-19.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPTextField.h"

@implementation LSPTextField
static NSString *const LSPPlaceholderColor = @"_placeholderLabel.textColor";
- (void)awakeFromNib
{
    //设置登陆内占位文字的颜色
    [self resignFirstResponder];
    //设置光标的颜色
    self.tintColor = self.textColor;
}
/**
 *  成为第一响应者的处理（文本框聚焦时调用）
 *
 */
- (BOOL)becomeFirstResponder
{
    //成为第一响应者时候占位文字变成输入文字颜色
    [self setValue:self.textColor forKeyPath:LSPPlaceholderColor];
    return [super becomeFirstResponder];
}
/**
 *  取消第一响应者的处理（文本框失去焦点时调用的方法）
 *
 */
- (BOOL)resignFirstResponder
{
    //取消第一响应者的时候占位文字变成灰色
    [self setValue:[UIColor grayColor] forKeyPath:LSPPlaceholderColor];
    return [super resignFirstResponder];
}
/*
- (void)drawPlaceholderInRect:(CGRect)rect
{
    [self.placeholder drawInRect:CGRectMake(0, 10, rect.size.width, 25) withAttributes:@{
        NSForegroundColorAttributeName : [UIColor redColor],
        NSFontAttributeName : self.font
                               }];
}
 */
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
