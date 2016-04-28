//
//  AppDelegate.h
//  百思不得姐
//
//  Created by mac on 16-2-4.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//
//改变statusBar的颜色:在plist文件中的“Application requires iPhone environment”添加“View controller-based status bar appearance”为“NO”,让状态来显示不要基于控制器

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

