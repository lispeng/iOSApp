//
//  LSPTopWindow.m
//  百思不得姐
//
//  Created by mac on 16-4-8.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPTopWindow.h"

@implementation LSPTopWindow
static UIWindow *window_;
+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, LSPScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topWindowClick)];
    [window_ addGestureRecognizer:tap];
}
+ (void)show
{
    window_.hidden = NO;//设置UIWindow对象显示
}
/**
 *  监听顶部窗口点击
 */
+ (void)topWindowClick
{
    //主窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}
+ (void)searchScrollViewInView:(UIView *)listView
{
    for (UIView *childView in listView.subviews) {
        /*
        //坐标系转换(获得在主窗口的左边newFrame)
        CGRect newFrame = [childView.superview convertRect:childView.frame toView:[UIApplication sharedApplication].keyWindow];
        CGRect windowBounds = [UIApplication sharedApplication].keyWindow.bounds;
        //判断一个控件是否真正显示在窗口内
        BOOL isShowing = childView.window == [UIApplication sharedApplication].keyWindow && !childView.isHidden && childView.alpha > 0.01 && CGRectIntersectsRect(newFrame, windowBounds);
         */
        //如果子控件是UIScrollView对象
        if ([childView isKindOfClass:[UIScrollView class]] && childView.isShowingOnKeyWindow) {
            UIScrollView *scrollView = (UIScrollView *)childView;
            //若果是UISCrollView对象就让其滚动到顶部
            CGPoint offset = scrollView.contentOffset;
            offset.y = -scrollView.contentInset.top;
            
            [scrollView setContentOffset:offset animated:YES];
        }
        //继续查找子控件
        [self searchScrollViewInView:childView];
    }
    

   }
@end
