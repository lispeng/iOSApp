//
//  LSPEssenceViewController.m
//  百思不得姐
//
//  Created by mac on 16-2-6.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPEssenceViewController.h"
#import "LSPRecommendTagsViewController.h"
#import "LSPTopicViewController.h"
@interface LSPEssenceViewController ()<UIScrollViewDelegate>
/**
 *  导航栏按钮下面的红色指示器
 */
@property (nonatomic,weak) UIView *indicatorView;
/**
 *  记录当前选中的按钮
 */
@property (strong,nonatomic) UIButton *selectedBtn;
/**
 *  导航栏下面的导航条
 */
@property (nonatomic,weak) UIView *titlesView;
/**
 *  背景容器
 */
@property (nonatomic,weak) UIScrollView *contentView;


@end

@implementation LSPEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置导航栏的内容
    [self setupEssenceNavigationBar];
    
    //初始化scrollView内部的子控制器
    [self setupChildController];
    
    //设置导航栏下面的工具选项条
    [self setupEssenceTitlesLineView];
    
    //设置背景scrollView
    [self setupEssenceBackgroundScrollView];
   
    // Do any additional setup after loading the view.
}
/**
 *  设置导航栏的内容
 */
- (void)setupEssenceNavigationBar
{
    //设置背景色
    self.view.backgroundColor = LSPBackgroundColor;
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(mainTagButtonClick)];
}
/**
 *  点击导航栏左边的按钮所触发的方法
 */
- (void)mainTagButtonClick
{
    LSPRecommendTagsViewController *tagsVC = [[LSPRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tagsVC animated:YES];
}
/**
 *  设置控制器view上面的容器UIScrollView对象
 */
- (void)setupEssenceBackgroundScrollView
{
    //不要自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    //创建UISCrollView对象
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
   // scrollView.backgroundColor = [UIColor orangeColor];
    scrollView.contentSize = CGSizeMake(scrollView.width * self.childViewControllers.count, 0);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view insertSubview:scrollView atIndex:0];
    self.contentView = scrollView;
    
    //添加第一个控制器的View
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
/**
 *  导航栏下面的工具选项条的设置
 */
- (void)setupEssenceTitlesLineView
{
    //背景容器设置
    UIView *bgView = [[UIView alloc] init];
    bgView.y = LSPTitlesViewY;
    bgView.width = self.view.width;
    bgView.height = LSPTitlesViewH;
    bgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:bgView];
    self.titlesView = bgView;
    //创建导航条按钮下面的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.height = 2;
    indicatorView.y = bgView.height - indicatorView.height;
    indicatorView.backgroundColor = [UIColor redColor];
     self.indicatorView = indicatorView;

    //背景容器里面的点击按钮设置
   // NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
   // NSInteger count = titles.count;
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = self.view.width / count;
    CGFloat btnH = bgView.height;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i < count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake(i * btnW, btnY, btnW, btnH);
        UIViewController *childVC = self.childViewControllers[i];
        [btn setTitle:childVC.title forState:UIControlStateNormal];
       
       // [btn layoutIfNeeded];//更新布局控件
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(essenceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
        
        //默认点击了第一个按钮
        if (0 == i) {
            btn.enabled = NO;
            self.selectedBtn = btn;
            //让按钮内部的label根据文字大小来计算尺寸
            [btn.titleLabel sizeToFit];
            self.indicatorView.width = btn.titleLabel.width;
            self.indicatorView.centerX = btn.centerX;
        }
        
    }
    [bgView addSubview:indicatorView];
   
    
}
/**
 *  点击导航按钮的触发方法
 *
 */
- (void)essenceBtnClick:(UIButton *)button
{
    //修改按钮的状态
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    //按钮底部指示器动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}
/**
 *  初始化scrollView内部的子控制器
 */
- (void)setupChildController
{
    //全部
    LSPTopicViewController *allVC = [[LSPTopicViewController alloc] init];
    
    allVC.type = LSPTopicTypeAll;
    allVC.title = @"全部";
    [self addChildViewController:allVC];

    //视频
    LSPTopicViewController *videoVC = [[LSPTopicViewController alloc] init];
    videoVC.type = LSPTopicTypeVideo;
    videoVC.title = @"视频";

    [self addChildViewController:videoVC];
        //声音
    LSPTopicViewController *voiceVC = [[LSPTopicViewController alloc] init];
    voiceVC.type = LSPTopicTypeVoice;
    voiceVC.title = @"声音";
    [self addChildViewController:voiceVC];
   
    //插图
    LSPTopicViewController *illustrationVC = [[LSPTopicViewController alloc] init];
    illustrationVC.type = LSPTopicTypeIllustration;
    illustrationVC.title = @"图片";

    [self addChildViewController:illustrationVC];
        //段子
    LSPTopicViewController *episodeVC = [[LSPTopicViewController alloc] init];
    episodeVC.type = LSPTopicTypeEpisode;
    episodeVC.title = @"段子";
    [self addChildViewController:episodeVC];
    
}

#pragma mark----<UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //获取当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //取出子控制器
    UITableViewController *childVC = self.childViewControllers[index];
    childVC.view.x = scrollView.contentOffset.x;
    childVC.view.y = 0;
    childVC.view.height = scrollView.height;//设置控制器的view的高度为整个屏幕的高度
    
    [scrollView addSubview:childVC.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self essenceBtnClick:self.titlesView.subviews[index]];
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
