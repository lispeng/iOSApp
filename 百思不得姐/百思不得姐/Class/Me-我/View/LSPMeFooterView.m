//
//  LSPMeFooterView.m
//  百思不得姐
//
//  Created by mac on 16-4-11.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPMeFooterView.h"
#include "AFNetworking.h"
#import "MJExtension.h"
#import "LSPSquare.h"
#import "LSPSquareButton.h"
#import "LSPWebViewController.h"
@implementation LSPMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        //发送请求
        [self requestNewMsg];
    }
    return self;
}
- (void)requestNewMsg
{
    //请求数据
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"square";
    dict[@"c"] = @"topic";
   
    [[AFHTTPSessionManager manager] GET:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *squares = [LSPSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        //创建方块
        [self createSquares:squares];
        
           } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
   
}
- (void)createSquares:(NSArray *)squares
{
    NSInteger count = squares.count;
    NSInteger maxCols = 4;
    //宽度和高度
    CGFloat buttonW = LSPScreenW / maxCols;
    CGFloat buttonH = buttonW;
    for (NSInteger i = 0; i < count; i ++) {
        
       //创建按钮
        LSPSquareButton *button = [LSPSquareButton buttonWithType:UIButtonTypeCustom];
        //传递模型数据
        button.square = squares[i];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        //计算按钮的frame
        NSInteger col = i % maxCols;
        NSInteger row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
        
        //计算控件的高度
        //self.height = CGRectGetMaxY(button.frame);
    }
    //计算总行数
    NSUInteger rows = (count + maxCols - 1) / maxCols;
    //计算FooterView的高度
    self.height = rows * buttonH;
    
    //重绘
    //[self setNeedsDisplay];
}

- (void)buttonClick:(LSPSquareButton *)button
{
    if(![button.square.url hasPrefix:@"http"]) return;
    
    LSPWebViewController *webVC = [[LSPWebViewController alloc] init];
    webVC.url = button.square.url;
    webVC.title = button.square.name;
    //取出当前的导航控制器
    UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
    [nav pushViewController:webVC animated:YES];
    
}
//- (void)drawRect:(CGRect)rect
//{
//    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
