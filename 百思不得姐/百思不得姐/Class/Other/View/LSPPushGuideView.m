//
//  LSPPushGuideView.m
//  百思不得姐
//
//  Created by mac on 16-3-25.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPPushGuideView.h"

@implementation LSPPushGuideView
/**
 *  加再进去Xib文件
 *
 *  @return <#return value description#>
 */
 + (instancetype)sharedGuideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LSPPushGuideView class]) owner:nil options:nil] lastObject];
}
/**
 *  显示引导页的方法
 */
+ (void)showGuidePage
{
    NSString *key = @"CFBundleShortVersionString";
    //获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //或去沙盒中存储的版本号
    NSString *sanVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //对比当前版本号与沙盒中的版本号是否相同
    if (![currentVersion isEqualToString:sanVersion]) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        //创建引导页对象并添加到主窗口中去
        LSPPushGuideView *guideView = [LSPPushGuideView sharedGuideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        //存储当前的版本号到沙盒中去
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        //立即同步存储到沙盒
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
/**
 *  关闭引导页的方法
 */
- (IBAction)closeGuidePage {
    //移除在窗口上的引导页
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
