//
//  UIImage+LSPExtension.m
//  百思不得姐
//
//  Created by mac on 16-4-11.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "UIImage+LSPExtension.h"

@implementation UIImage (LSPExtension)
- (UIImage *)circleImage
{
    //开启图形上下文(NO代表透明)
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    //获取当前图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //画圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    //裁剪
    CGContextClip(ctx);
    //画图片到上下文
    [self drawInRect:rect];
    //获取土行上下文中的图片
   UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭土行上下文
    UIGraphicsEndImageContext();
   
    return image;
}
@end
