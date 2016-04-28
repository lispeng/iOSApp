//
//  LSPMeViewController.m
//  百思不得姐
//
//  Created by mac on 16-2-6.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPMeViewController.h"
#import "LSPMeCell.h"
#import "LSPMeFooterView.h"
#import "AFNetworking.h"
#import "LSPSettingViewController.h"
@interface LSPMeViewController ()

@end

@implementation LSPMeViewController
static NSString *LSPMeId = @"me";
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏的内容
    [self setupMeTrendsNavigationBar];
    //设置tableView
    [self setupTableView];
    // Do any additional setup after loading the view.
}
/**
 *  设置导航栏的内容
 */
- (void)setupMeTrendsNavigationBar
{
        //设置导航栏标题
    self.navigationItem.title = @"我的";
    //设置导航栏左边的按钮    
    UIBarButtonItem *mineSettingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightImage:@"mine-setting-icon-click" target:self action:@selector(mineSettingButtonClick)];
    UIBarButtonItem *mineMoonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightImage:@"mine-moon-icon-click" target:self action:@selector(mineMoonButtonClick)];
    self.navigationItem.rightBarButtonItems = @[mineSettingItem,mineMoonItem];
    
    
}

- (void)setupTableView
{
    //设置背景色
    self.tableView.backgroundColor = LSPBackgroundColor;
    //tableViewCell处理
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[LSPMeCell class] forCellReuseIdentifier:LSPMeId];
    //header和footer的高度设置
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = LSPTopicCellMargin;
    
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    self.tableView.tableFooterView = [[LSPMeFooterView alloc] init];
}
/**
 *  点击设置按钮所触发的方法
 */
- (void)mineSettingButtonClick
{
    LSPSettingViewController *settingVC = [[LSPSettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:settingVC animated:YES];
}
/**
 *  点击导航栏夜间模式的按钮所触发的方法
 */
- (void)mineMoonButtonClick
{
    LSPLog(@"%s",__func__);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSPMeCell *cell = [tableView dequeueReusableCellWithIdentifier:LSPMeId];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"注册/登陆";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"离线下载";
    }
    
  
    return cell;
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
