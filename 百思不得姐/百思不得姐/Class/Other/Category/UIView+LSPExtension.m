//
//  UIView+LSPExtension.m
//  百思不得姐
//
//  Created by mac on 16-2-6.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "UIView+LSPExtension.h"

@implementation UIView (LSPExtension)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height
{
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size
{
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY
{
    return self.center.y;
}
/**
 *  判断一个控件是否真正显示在主窗口上
 *
 */
- (BOOL)isShowingOnKeyWindow
{
    //获取主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    //以主窗口左上角为坐标原点计算self的坐标矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winFrame = keyWindow.frame;
    //self的frame矩形框是否与主窗口有交叉
    BOOL intersect = CGRectIntersectsRect(newFrame, winFrame);
    //判断一个控件是否真正显示在主窗口上面
    BOOL isShowing = (self.window == keyWindow) && !self.isHidden && self.alpha > 0.01 && intersect;
    
    return isShowing;
}
+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
@end
