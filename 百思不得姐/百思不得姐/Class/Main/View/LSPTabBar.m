//
//  LSPTabBar.m
//  百思不得姐
//
//  Created by mac on 16-2-6.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPTabBar.h"
#import "LSPPublishViewController.h"
@interface LSPTabBar()
/**
 *  发布按钮
 */
@property (weak,nonatomic) UIButton *publishButton;
@end
@implementation LSPTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置tabBar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}
- (void)publishClick
{
    //弹出发布控制器
    LSPPublishViewController *publishVC = [[LSPPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:nil];
}
/**
 *  布局UITabBar里面的子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //布局发布按钮publishButton这个子控件
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    //布局UITabBarButton的位置属性
    CGFloat index = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width / 5;
    CGFloat buttonH = self.height;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        //计算UITabBarButton类型的按钮的尺寸布局
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //增加索引值
        index ++;
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
