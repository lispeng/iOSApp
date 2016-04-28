//
//  UIBarButtonItem+LSPExtension.h
//  百思不得姐
//
//  Created by mac on 16-2-6.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LSPExtension)
/**
 *  创建UIBarButtonItem对象的方法
 *
 */
+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action;
@end
