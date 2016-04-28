//
//  LSPCommentViewController.m
//  百思不得姐
//
//  Created by mac on 16-4-6.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//评论内容的控制界面

#import "LSPCommentViewController.h"
#import "LSPEpisodeCell.h"
#import "LSPEpisode.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "LSPComment.h"
#import "MJExtension.h"
#import "LSPCommentHeaderView.h"
#import "LSPCommentCell.h"

static NSString *const LSPCommentID = @"comment";
//static NSInteger const LSPHeaderTag = 99;
@interface LSPCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) AFHTTPSessionManager *mgr;
/**
 *  最热评论
 */
@property (strong,nonatomic) NSArray *hotComments;
/**
 *  最新评论
 */
@property (strong,nonatomic) NSMutableArray *latestComments;
/**
 *  保存数据
 */
@property (strong,nonatomic) LSPComment *saved_top_cmt;
/**
 *  当前的页码
 */
@property (nonatomic, assign) NSInteger page;
@end

@implementation LSPCommentViewController

- (AFHTTPSessionManager *)mgr
{
    if (nil == _mgr) {
        
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}
- (NSMutableArray *)latestComments
{
    if (nil == _latestComments) {
        _latestComments = [NSMutableArray array];
    }
    return _latestComments;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化控件
    [self setupCommentChildView];
    //初始化表视图控件的头部
    [self setupHeaderView];
   //刷新加载数据
    [self setupCommentRefresh];
    // Do any additional setup after loading the view from its nib.
}
/**
 *  刷新加载数据
 */
- (void)setupCommentRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    //一旦进入页面就开始加载数据
    [self.tableView.mj_header beginRefreshing];
    
    //上拉加载更多评论数据
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    
    self.tableView.mj_footer.hidden = YES;
}
/**
 *  下拉刷新加载数据
 */
- (void)loadNewComments
{
    //结束之前的请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    //下拉加载时请求数据
    [self.mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //如果没有评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]){
            
            //结束刷新
            [self.tableView.mj_header endRefreshing];
            
            return;
        }
        //最热评论模型
        self.hotComments = [LSPComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //最新评论模型
        self.latestComments = [LSPComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //取回第一页
        self.page = 1;
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}
/**
 *  上拉加载更多评论数据
 */
- (void)loadMoreComments
{
    
    //结束之前的请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSInteger page = self.page + 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    LSPComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] =cmt.ID;
    //下拉加载时请求数据
    [self.mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //如果没有评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        //最热评论模型
        self.hotComments = [LSPComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //最新评论模型
        NSArray *newComments = [LSPComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];
        //取值当前页码
        self.page = page;
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {
           // [self.tableView.mj_footer endRefreshingWithNoMoreData];
            self.tableView.mj_footer.hidden = YES;
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];

}
/**
 *  初始化子控件
 */
- (void)setupCommentChildView
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highlightImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    //设置全局色
    self.tableView.backgroundColor = LSPBackgroundColor;
    //监听键盘弹出的方式
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //LSPCommentCell对象的高度处理，autolayout自动自己算的处理
    self.tableView.estimatedRowHeight = 44;//估计高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //注册LSPCommentCell对象
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LSPCommentCell class]) bundle:nil] forCellReuseIdentifier:LSPCommentID];
    
    //取出tableView中的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, LSPTopicCellMargin, 0);
}

- (void)keyboardWillChangeFrame:(NSNotification *)noti
{
    //获取键盘显示或隐藏完毕后的frame值
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //键盘高度处理
    self.bottomSpace.constant = LSPScreenH - frame.origin.y;
    //键盘弹出动画处理
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //动画
    [UIView animateWithDuration:duration animations:^{
        //强制更新布局
        [self.view layoutIfNeeded];
    }];
    
}
/**
 *  初始化tableView的头部控件
 */
- (void)setupHeaderView
{
    UIView *headerView = [[UIView alloc] init];
    
//    if(self.topic.top_cmt){
//    //先保存一份最热评论的数据
//    self.saved_top_cmt = self.topic.top_cmt;
//    //先清空最新评论的数据
//    self.topic.top_cmt = nil;
//    //更改cell高度
//    [self.topic setValue:@0 forKeyPath:@"cellHeight"];
//    }
    LSPEpisodeCell *headerCell = [LSPEpisodeCell cell];
    headerCell.topic = self.topic;
//    headerCell.height = self.topic.cellHeight;
//    headerCell.width = headerView.width;
    headerCell.size = CGSizeMake(LSPScreenW, self.topic.cellHeight);
    //设置自动伸缩属性
    //headerCell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [headerView addSubview:headerCell];
    //设置headerView的高度
    headerView.height = self.topic.cellHeight + LSPTopicCellMargin;
    self.tableView.tableHeaderView = headerView;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    if(self.saved_top_cmt){
//    //恢复最热评论top_cmt中的数据
//    self.topic.top_cmt = self.saved_top_cmt;
//        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
//    }
    //取消所有请求任务
    [self.mgr invalidateSessionCancelingTasks:YES];
}
#pragma mark--UITableViewDelegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
    //退出UIMenuController菜单
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if (hotCount) return 2;//有“最热评论” + “最新评论”
    if(latestCount) return 1;//只有“最新评论”
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    //隐藏尾部刷新控件
    tableView.mj_footer.hidden = (latestCount == 0);
    if(0 == section)//第0组的数据处理
    {
        return hotCount ? hotCount : latestCount;
    }
    //else if (1 == section) return latestCount;//第1组
    //不是第0组
    return latestCount;
}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
     NSInteger hotCount = self.hotComments.count;
    if(0 == section)
    {
        return hotCount ? @"最热评论" : @"最新评论";
    }
    return @"最新评论";
}
*/
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
 
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = LSPBackgroundColor;
    
    UILabel *cellHeaderLabel = [[UILabel alloc] init];
    cellHeaderLabel.backgroundColor = [UIColor redColor];
    cellHeaderLabel.textColor = LSPColor(67, 67, 67);
    cellHeaderLabel.x = LSPTopicCellMargin;
    cellHeaderLabel.width = 200;
    cellHeaderLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    NSInteger hotCount = self.hotComments.count;
    if(0 == section)
    {
        cellHeaderLabel.text = hotCount ? @"最热评论" : @"最新评论";
    }else{
    cellHeaderLabel.text = @"最新评论";
    }
    [header addSubview:cellHeaderLabel];
    return header;
 
    static NSString *ID = @"header";
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    UILabel *cellHeaderLabel = nil;
    if (nil == header) {//缓存池中没有，从新创建header对象
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:ID];
        header.contentView.backgroundColor = LSPBackgroundColor;
        cellHeaderLabel = [[UILabel alloc] init];
        
        cellHeaderLabel.textColor = LSPColor(67, 67, 67);
        cellHeaderLabel.x = LSPTopicCellMargin;
        cellHeaderLabel.width = 200;
        cellHeaderLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        cellHeaderLabel.tag = LSPHeaderTag;
        [header.contentView addSubview:cellHeaderLabel];
    }else{//缓存池中有header对象
        
        cellHeaderLabel = (UILabel *)[header viewWithTag:LSPHeaderTag];
    }
    //设置cellHeaderLabel的数据
    NSInteger hotCount = self.hotComments.count;
    if(0 == section)
    {
        cellHeaderLabel.text = hotCount ? @"最热评论" : @"最新评论";
    }else{
        cellHeaderLabel.text = @"最新评论";
    }
    [header addSubview:cellHeaderLabel];

    return header;
}
*/

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LSPCommentHeaderView *header = [LSPCommentHeaderView headerFooterViewWithTableView:tableView];
    NSInteger hotCount = self.hotComments.count;
    if(0 == section)
    {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    }else{
        header.title = @"最新评论";
    }
   
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSPCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:LSPCommentID];
       cell.comment = [self commentInIndexPath:indexPath ];
    
   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建UIMenuController
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {//避免重复点击
        [menu setMenuVisible:NO animated:YES];
       
    }else{
     //获取被点击的cell对象
    LSPCommentCell *cell = (LSPCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
    //让cell成为第一响应者
    [cell becomeFirstResponder];
    
    
    UIMenuItem *dingItem = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
    UIMenuItem *replayItem = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
    UIMenuItem *reportItem = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
    
    menu.menuItems = @[dingItem,replayItem,reportItem];

    //设置显示区域
    CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
    [menu setTargetRect:rect inView:cell];
    [menu setMenuVisible:YES animated:YES];
    }
}
- (void)ding:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"顶-->%zd",indexPath.row);
}
- (void)replay:(UIMenuController *)menu
{
    NSLog(@"回复");
}
- (void)report:(UIMenuController *)menu
{
    NSLog(@"举报");
}

/**
 *  返回第section组的数组
 *
 */
- (NSArray *)commentsInSection:(NSInteger)section
{
     NSInteger hotCount = self.hotComments.count;
    if (0 == section) {
        return hotCount ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}
/**
 *  返回某一行的评论模型
 *
 */
- (LSPComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
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
