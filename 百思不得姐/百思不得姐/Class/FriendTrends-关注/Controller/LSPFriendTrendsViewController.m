//
//  LSPFriendTrendsViewController.m
//  百思不得姐
//
//  Created by mac on 16-2-6.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPFriendTrendsViewController.h"
#import "LSPRecommendViewController.h"
#import "LSPLoginRegisterViewController.h"
@interface LSPFriendTrendsViewController ()
- (IBAction)loginRegisterClick;

@end

@implementation LSPFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏的内容
    [self setupFriendTrendsNavigationBar];

    // Do any additional setup after loading the view.
}
/**
 *  设置导航栏的内容
 */
- (void)setupFriendTrendsNavigationBar
{
    //设置背景色
    self.view.backgroundColor = LSPBackgroundColor;
    //设置导航栏标题
    self.navigationItem.title = @"我的关注";
    //设置导航栏左边的按钮    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsButtonClick)];
}
/**
 *  点击导航栏左边的按钮所触发的方法
 */
- (void)friendsButtonClick
{
    LSPRecommendViewController *recommendVC = [[LSPRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommendVC animated:YES];
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
/**
 *  点击立即登录注册按钮触发的方法
 */
- (IBAction)loginRegisterClick {
    //跳转到登录注册控制器
    LSPLoginRegisterViewController *loginRegister = [[LSPLoginRegisterViewController alloc] init];
    [self presentViewController:loginRegister animated:YES completion:nil];
     
}
@end
