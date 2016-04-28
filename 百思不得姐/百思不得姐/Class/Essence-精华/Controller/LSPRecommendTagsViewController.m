//
//  LSPRecommendTagsViewController.m
//  百思不得姐
//
//  Created by mac on 16-2-18.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPRecommendTagsViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "LSPRecommendTag.h"
#import "LSPRecommendTagCell.h"
@interface LSPRecommendTagsViewController ()
/**
 *  存放标签请求来的数据
 */
@property (strong,nonatomic) NSArray *tags;
/**
 *  AFN请求管理者
 */
@property (strong,nonatomic) AFHTTPSessionManager *tagManager;

@end

@implementation LSPRecommendTagsViewController

static NSString *const LSPRecommendTagsID = @"recommendTag";
- (AFHTTPSessionManager *)tagManager
{
    if (!_tagManager) {
        _tagManager = [AFHTTPSessionManager manager];
    }
    return _tagManager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化控件
    [self setupRecommendTags];
    //发送网络请求
    [self requestRecommendTags];
   
}
/**
 *  初始化控件
 */
- (void)setupRecommendTags
{
    //设置标题
    self.title = @"推荐标签";
    //设置cell的高度
    self.tableView.rowHeight = 70;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LSPRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:LSPRecommendTagsID];
    //取消cell的分割线
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置tableView的背景色
    self.tableView.backgroundColor = LSPBackgroundColor;
}
/**
 *  推荐标签的网络请求
 */
- (void)requestRecommendTags
{
    //发送请求之前先添加一层遮盖
[SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    //创建请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    //开启网络请求
    [self.tagManager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //字典转模型
        self.tags = [LSPRecommendTag objectArrayWithKeyValuesArray:responseObject];
        //取消遮盖
        [SVProgressHUD dismiss];
       //刷新数据
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //提醒加载失败
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSPRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:LSPRecommendTagsID];
    cell.recommendTag = self.tags[indexPath.row];
   
    return cell;
}

#pragma mark--- 控制器销毁时的处理
- (void)dealloc
{
    //取消所有网络请求
    [self.tagManager.operationQueue cancelAllOperations];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
