//
//  UIView+LSPExtension.h
//  百思不得姐
//
//  Created by mac on 16-2-6.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LSPExtension)
/**
 *  设置frame属性的x值
 */
@property (assign,nonatomic) CGFloat x;
/**
 *  设置frame属性的y值
 */
@property (assign,nonatomic) CGFloat y;
/**
 *  设置frame属性的width值
 */
@property (assign,nonatomic) CGFloat width;
/**
 *  设置frame属性的height值
 */
@property (assign,nonatomic) CGFloat height;
/**
 *  设置frame属性的size值
 */
@property (nonatomic, assign) CGSize size;
/**
 *  设置UIView的centerX
 */
@property (assign,nonatomic) CGFloat centerX;
/**
 *  设置UIView的centerY
 */
@property (assign,nonatomic) CGFloat centerY;
/**
 *  判断一个控件是否真正显示在主窗口上
 *
 */
- (BOOL)isShowingOnKeyWindow;

+ (instancetype)viewFromXib;
@end
