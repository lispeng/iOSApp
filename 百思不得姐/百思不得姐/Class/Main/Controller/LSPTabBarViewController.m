//
//  LSPTabBarViewController.m
//  百思不得姐
//
//  Created by mac on 16-2-4.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPTabBarViewController.h"
#import "LSPNavigationController.h"
#import "LSPEssenceViewController.h"
#import "LSPNewViewController.h"
#import "LSPFriendTrendsViewController.h"
#import "LSPMeViewController.h"
#import "LSPTabBar.h"
@interface LSPTabBarViewController ()

@end

@implementation LSPTabBarViewController
/**
 *  当第一次使用这个类的时候就会调用initialize方法
 */
+ (void)initialize
{
    //统一设置tabBarItem的文字属性
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    dict[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectDict = [NSMutableDictionary dictionary];
    selectDict[NSFontAttributeName] = dict[NSFontAttributeName];
    selectDict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectDict forState:UIControlStateSelected];

    //[self setupTabBarItemAttributes];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addController];
}
/**
 *  添加子控制器
 */
- (void)addController
{
    
       //精华---控制器
    [self setupChildViewController:[[LSPEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    
   //新帖---控制器
    [self setupChildViewController:[[LSPNewViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    

    //关注---控制器
    [self setupChildViewController:[[LSPFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];

    //我---控制器
    [self setupChildViewController:[[LSPMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
    
    //用自定义的LSPTabBar导航条对象替换掉UITabBarController底部的tabBar导航条
    [self setValue:[[LSPTabBar alloc] init] forKeyPath:@"tabBar"];
    
    
}
/**
 *  统一设置UITarBarItem的文字属性的函数封装
 */
/*
- (void)setupTabBarItemAttributes
{
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    dict[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectDict = [NSMutableDictionary dictionary];
    selectDict[NSFontAttributeName] = dict[NSFontAttributeName];
    selectDict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectDict forState:UIControlStateSelected];
}
 */
/**
 *  初始化子控制器的封装函数
 *
  */
- (void)setupChildViewController:(UIViewController *)controller title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    controller.navigationItem.title = title;
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:image];
    controller.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    
    //创建导航控制器，让导航控制器成为UITabViewController控制器的子控制器
    LSPNavigationController *nav = [[LSPNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nav];
    
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
