//
//  LSPTopicViewController.m
//  百思不得姐
//
//  Created by mac on 16-3-24.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPTopicViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "LSPEpisode.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "LSPEpisodeCell.h"
#import "LSPCommentViewController.h"
#import "LSPNewViewController.h"
@interface LSPTopicViewController ()
/**
 *  帖子数据
 */
@property (strong,nonatomic) NSMutableArray *topics;
/**
 *  当前页码
 */
@property (nonatomic, assign) NSInteger currentPage;
/**
 *  当加载下一页数据时需要的参数
 */
@property (copy,nonatomic) NSString *maxtime;
/**
 *  上一次的请求参数
 */
@property (strong,nonatomic) NSDictionary *params;
/**
 *  上一次选中的索引
 */
@property (assign,nonatomic) NSInteger lastSelectedIndex;
@end

@implementation LSPTopicViewController
- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
//- (NSString *)type
//{
//    return nil;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupEpisodeView];
    //刷新数据
    [self refreshNewEpisodeData];
    //获取段子页面的请求数据
    [self requestNewEpisodeData];
}
static NSString *const identifier = @"episodeCell";
- (void)setupEpisodeView
{
    //设置内边距
    CGFloat top = LSPTitlesViewY + LSPTitlesViewH;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //取出分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //清除背景颜色
    self.tableView.backgroundColor = [UIColor clearColor];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LSPEpisodeCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    //监听通知
    [LSPNotiCenter addObserver:self selector:@selector(tabBarDidSelect) name:LSPTabBarDidSelectNotification object:nil];
}

- (void)tabBarDidSelect
{
    //如果是连续点中两次，就直接刷新
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && self.view.isShowingOnKeyWindow) {
        
        [self.tableView.mj_header beginRefreshing];
    }
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
    
}
- (NSString *)a
{
    return [self.presentedViewController isKindOfClass:[LSPNewViewController class]] ? @"newlist" : @"list";
}

/**
 *  先刷新表格数据
 */
- (void)refreshNewEpisodeData
{
    //下拉加载数据
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNewEpisodeData)];
    //刷新控件的透明度改变(根据拖拽比例自动改变透明度)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //一旦进入此控制器就自动刷新
    [self.tableView.mj_header beginRefreshing];
    
    //上拉加载更多数据
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreEpisodeUsers)];
}
/**
 *  获取段子控制器页面的请求数据
 */
- (void)requestNewEpisodeData
{
    //先结束上拉加载控件
    [self.tableView.mj_footer endRefreshing];
    
    //请求数据
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = self.a;
    dict[@"c"] = @"data";
    dict[@"type"] = @(self.type);
    self.params = dict;
    [[AFHTTPSessionManager manager] GET:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        //当用户出现下拉和上拉几乎同时请求加载数据的时候，为避免出现数据混乱的情况，解决办法是要以用户最后一次请求加载为准
        if (self.params != dict) return;
        //取出maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //运用第三方框架进行字典转模型
        self.topics = [LSPEpisode objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新数据重新加载
        [self.tableView reloadData];
        //加载完成数据就停止刷新
        [self.tableView.mj_header endRefreshing];
        //一旦加载新数据的时候当前页码应初始化为第一页（后台默认为0）
        self.currentPage = 0;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //加载数据失败停止刷新
        [self.tableView.mj_header endRefreshing];
        //当用户出现下拉和上拉几乎同时请求加载数据的时候，为避免出现数据混乱的情况，解决办法是要以用户最后一次请求加载为准
        if (self.params != dict) return;
    }];
}
/**
 *  上拉加载更多数据
 */
- (void)loadMoreEpisodeUsers
{
    //先结束下拉加载控件
    [self.tableView.mj_header endRefreshing];
    //当下拉加载更多数据时，意味着加载了下一页数据
    self.currentPage ++;
    //下拉加载数据请求
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = self.a;
    dict[@"c"] = @"data";
    dict[@"type"] = @(self.type);
    dict[@"maxtime"] = self.maxtime;
    dict[@"page"] = @(self.currentPage);
    self.params = dict;
    
    [[AFHTTPSessionManager manager] GET:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        //当用户出现下拉和上拉几乎同时请求加载数据的时候，为避免出现数据混乱的情况，解决办法是要以用户最后一次请求加载为准
        if (self.params != dict) return;
        //存储请求到来的maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //运用第三方框架进行字典转模型
        NSArray *newtopics = [LSPEpisode objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newtopics];
        //刷新数据重新加载
        [self.tableView reloadData];
        //加载完成数据就停止刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //加载数据失败停止刷新
        [self.tableView.mj_footer endRefreshing];
        //加载数据失败要恢复页码
        self.currentPage --;
        //当用户出现下拉和上拉几乎同时请求加载数据的时候，为避免出现数据混乱的情况，解决办法是要以用户最后一次请求加载为准
        if (self.params != dict) return;
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSPEpisodeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.topic = self.topics[indexPath.row];
    return cell;
}

#pragma mark--代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出对应的帖子模型
    LSPEpisode *topic = self.topics[indexPath.row];
   
    return topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSPCommentViewController *commentVC = [[LSPCommentViewController alloc] init];
    //传递模型数据
    commentVC.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
}

@end
