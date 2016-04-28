//
//  LSPRecommendViewController.m
//  百思不得姐
//
//  Created by mac on 16-2-17.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPRecommendViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "LSPRecommendCategory.h"
#import "LSPRecommendCategoryCell.h"
#import "LSPRecommendUserCell.h"
#import "LSPRecommendUser.h"
#define LSPSelectedCategory self.categories[self.recommendTableView.indexPathForSelectedRow.row]
@interface LSPRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  左侧的类别列表
 */
@property (weak, nonatomic) IBOutlet UITableView *recommendTableView;
/**
 *  右侧的用户详细列表
 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/**
 *  存放左侧类别的模型数据
 */
@property (strong,nonatomic) NSArray *categories;
/**
 *  请求参数
 */
@property (strong,nonatomic) NSMutableDictionary *params;
/**
 *  AFN的请求管理者
 */
@property (strong,nonatomic) AFHTTPSessionManager *manager;
@end

@implementation LSPRecommendViewController

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
//左边的cell标识
static NSString *const leftCategoryID = @"leftRecommendCategoryCell";
//右边cell的标识
static NSString *const rightUserID = @"userTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化tableView
    [self setupTableView];
    //集成刷新控件
    [self setupRefresh];
    //开启网络请求
    [self httpRequestAttention];
    // Do any additional setup after loading the view from its nib.
}
/**
 *  初始化tableView的方法
 */
- (void)setupTableView
{
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = LSPBackgroundColor;
    //注册左边category中tableView的cell
    [self.recommendTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LSPRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:leftCategoryID];
    //注册右边userTableView中的cell
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LSPRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:rightUserID];
    //设置tableView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.recommendTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.recommendTableView.contentInset;
    self.userTableView.rowHeight = 71;
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    //集成下拉刷新
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    //上拉刷新自动加载数据
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    //刚开始请求的时候先隐藏刷新控件,有数据的时候再显示刷新
    self.userTableView.mj_footer.hidden = YES;
}
/**
 *  下拉刷新加载更多新数据
 */
- (void)loadNewUsers
{
    LSPRecommendCategory *user = LSPSelectedCategory;
    //设置当前的页码为第一页
    user.currentPage = 1;
    //点击左侧的按钮会发送相应的网络请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(user.id);
    params[@"page"] = @(user.currentPage);
    self.params = params;
    //用户的数据请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //先清空以前的旧数据，防止重复下拉加载数据
        [user.users removeAllObjects];
        
        NSArray *userModels = [LSPRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //把请求到的数据添加进去数组
        [user.users addObjectsFromArray:userModels];
        
        //保存总数
        user.total = [responseObject[@"total"] integerValue];
        
        //防止用户点击多次造成重复请求
        if(self.params != params) return;

        
        //刷新表格的数据
        [self.userTableView reloadData];
       //结束刷新
        [self.userTableView.mj_header endRefreshing];
        //在下拉刷新中判断数据是否全部加载完毕（数据是否只有一页）,若全部加载完毕就不需要上拉刷新数据
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if(self.params != params) return;
        //提醒加载用户数据失败
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
    }];

}
/**
 *  上拉刷新加载更多数据的方法
 */
- (void)loadMoreUsers
{
    LSPRecommendCategory *category = LSPSelectedCategory;
    //点击左侧的按钮会发送相应的网络请求
   
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++ category.currentPage);
    self.params = params;
    //用户的数据请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
       
        
        NSArray *userModels = [LSPRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //把请求到的数据添加进对应的用户数组
        [category.users addObjectsFromArray:userModels];
        
        //如果发现这一次的请求和上一次的请求不一样就直接返回，直到获取到最终的请求为止
        if(self.params != params) return;
        
        //刷新表格的数据
        [self.userTableView reloadData];
        
        //用户数组中的数据与总据数相等时表示数据加载完毕
        
        [self checkFooterState];
        //让底部控件结束刷新
       // [self.userTableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(self.params != params) return;
        //让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];

}
/**
 *  推荐关注的左侧的网络请求
 */
- (void)httpRequestAttention
{
    //显示指示器
[SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    //开启推荐关注的左侧的数据请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
      //LSPLog(@"responseObject = %@",responseObject);
        //字典转模型
        self.categories = [LSPRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //隐藏指示器
        [SVProgressHUD dismiss];
        //刷新表格
        [self.recommendTableView reloadData];
        //设置左侧的默认选中首航cell
        [self.recommendTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        //进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //显示加载失败的信息，同时也能隐藏指示器
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}
#pragma mark--- <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.recommendTableView == tableView) //判断如果是左边的tableView类型
        
        return self.categories.count;
    //右边的tableView类型
    
    //在下拉刷新中判断数据是否全部加载完毕（数据是否只有一页）,若全部加载完毕就不需要上拉刷新数据
        [self checkFooterState];
    LSPRecommendCategory *user = LSPSelectedCategory;
    NSInteger count = [[user users] count];
        
        return count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.recommendTableView) {//判断如果是左边的tableView
        
      LSPRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCategoryID];
    cell.category = self.categories[indexPath.row];
    return cell;
        
    }else{//右边的tableView
        LSPRecommendUserCell *userCell = [tableView dequeueReusableCellWithIdentifier:rightUserID];
        //取出左边的点击的数据模型
        LSPRecommendCategory *category = self.categories[self.recommendTableView.indexPathForSelectedRow.row];
       // userCell.user = [LSPSelectedCategory users][indexPath.row];
        
        userCell.user = category.users[indexPath.row];
        return userCell;
    }
    
}
#pragma mark---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //先结束上一次的刷新
    [self.userTableView.mj_header endRefreshing];
    
    //当用户点击category控件的时候，应停止上一次的刷新请求
    [self.userTableView.mj_footer endRefreshing];
    //取出左侧的模型数据
    LSPRecommendCategory *leftModel = self.categories[indexPath.row];
    //对重复发送数据请求的解决方案
    if (leftModel.users.count) {//有数据不发送请求
        
        //直接刷新表格
        [self.userTableView reloadData];
        
    }else{
        //立即刷新表格，立马显示用户点击的category当前的数据，避免网络延迟会让用户看到category上一次残留的数据
        [self.userTableView reloadData];
        //进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }
}
/**
 *  时刻检测底部footer的刷新状态
 */
- (void)checkFooterState
{
    LSPRecommendCategory *user = LSPSelectedCategory;
    
    //没有数据就隐藏下来刷新控件，有数据就显示下拉刷新控件
    NSInteger count = [[user users] count];
    self.userTableView.mj_footer.hidden = (count == 0);
    
    //在下拉刷新中判断数据是否全部加载完毕（数据是否只有一页）,若全部加载完毕就不需要上拉刷新数据
    if (user.users.count == user.total) {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        
        //让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--- 控制器的销毁
- (void)dealloc
{
    //停止所有请求
    [self.manager.operationQueue cancelAllOperations];
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
