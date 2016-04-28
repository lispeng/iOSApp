//
//  LSPPlaceholderTextView.h
//  百思不得姐
//
//  Created by mac on 16-4-12.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSPPlaceholderTextView : UITextView
/**
 *  占位文字
 */
@property (copy,nonatomic) NSString *placeholder;
/**
 *  占位文字的颜色
 */
@property (strong,nonatomic) UIColor *placeholderColor;
@end
