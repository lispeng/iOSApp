//
//  UIBarButtonItem+LSPExtension.m
//  百思不得姐
//
//  Created by mac on 16-2-6.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "UIBarButtonItem+LSPExtension.h"

@implementation UIBarButtonItem (LSPExtension)
+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action
{
    UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [itemButton setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [itemButton setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    itemButton.size = itemButton.currentBackgroundImage.size;
    [itemButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:itemButton];
}
@end
