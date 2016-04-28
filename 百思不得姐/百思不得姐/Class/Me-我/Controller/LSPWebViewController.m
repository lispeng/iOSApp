//
//  LSPWebViewController.m
//  百思不得姐
//
//  Created by mac on 16-4-11.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPWebViewController.h"
#import <NJKWebViewProgress.h>
@interface LSPWebViewController ()<UIWebViewDelegate>
/**
 *  进度代理对象
 */
@property (strong,nonatomic) NJKWebViewProgress *progress;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;

@end

@implementation LSPWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载新网页
    [self loadWebView];
    // Do any additional setup after loading the view from its nib.
}
/**
 *  加载新网页
 */
- (void)loadWebView
{
    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress){
        
        weakSelf.progressView.progress = progress;
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    
    self.progress.webViewProxyDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}
/**
 *  刷新
 *
 */
- (IBAction)refresh:(id)sender {
    //重新加载
    [self.webView reload];
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}
#pragma mark--<UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBackItem.enabled = webView.canGoBack;
    LSPLog(@"cangoback = %d",self.goForwardItem.enabled);
    self.goForwardItem.enabled = webView.canGoForward;
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
