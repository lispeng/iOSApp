//
//  LSPNewViewController.m
//  百思不得姐
//
//  Created by mac on 16-2-6.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPNewViewController.h"

@interface LSPNewViewController ()

@end

@implementation LSPNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏的内容
    [self setupNewNavigationBar];
    // Do any additional setup after loading the view.
}
/**
 *  设置导航栏的内容
 */
- (void)setupNewNavigationBar
{
    //设置背景色
    self.view.backgroundColor = LSPBackgroundColor;
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(lateButtonClick)];
}
/**
 *  点击导航栏左边的按钮所触发的方法
 */
- (void)lateButtonClick
{
    LSPLog(@"%s",__func__);
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
