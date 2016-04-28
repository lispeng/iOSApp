//
//  LSPNavigationController.m
//  百思不得姐
//
//  Created by mac on 16-2-17.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPNavigationController.h"

@interface LSPNavigationController ()

@end

@implementation LSPNavigationController
/**
 *  当第一次使用这个类的时候就会调用initialize方法
 */
+ (void)initialize
{
    //设置导航栏的背景图图片
   // [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //normal状态下文字
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    //Disabled状态下的文字
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    //itemDisabledAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //如果滑动移除控制器功能消失，清除代理，导航控制器会重新设置代理
    self.interactivePopGestureRecognizer.delegate = nil;
    // Do any additional setup after loading the view.
}
/**
 *  拦截push方法，设置push进去的控制器的相关内容
 *
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.childViewControllers.count > 0)//判断是不是Push进来的控制器
    {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 70, 30);
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backBtn setTitle:@"返回" forState:UIControlStateHighlighted];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        //当push进来控制器的时候，自动隐藏底部的tabBar导航条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    }
/**
 *  点击返回键按钮触发的方法
 */
- (void)backClick
{
    [self popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
