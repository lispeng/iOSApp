//
//  LSPPostWordViewController.m
//  百思不得姐
//
//  Created by mac on 16-4-12.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//*************发布文字-段子的控制器***************/

#import "LSPPostWordViewController.h"
#import "LSPPlaceholderTextView.h"
#import "LSPAddTagToobar.h"
@interface LSPPostWordViewController ()<UITextViewDelegate>
/**
 *  文本输入框
 */
@property (nonatomic,weak) UITextView *textView;
/**
 *  键盘顶部的工具条
 */
@property (nonatomic,weak) LSPAddTagToobar *toolbar;

@end

@implementation LSPPostWordViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self.textView resignFirstResponder];
    //先退出之前的键盘，再弹出现在的键盘
    [self.view endEditing:YES];
    [self.textView becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //初始化控件
    [self setupPostWordControl];
    //设置文本输入框
    [self setupTextView];
    //设置键盘的顶部控件
    [self setupToolbar];
}
- (void)setupPostWordControl
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(postWord)];
    //右侧按钮默认不能点击
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
}
- (void)setupTextView
{
    LSPPlaceholderTextView *textView = [[LSPPlaceholderTextView alloc] init];
    textView.delegate = self;
    textView.frame = self.view.bounds;
    //设置键盘顶部的工具条
   // textView.inputAccessoryView = [LSPAddTagToobar viewFromXib];
    textView.placeholderColor = [UIColor redColor];
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    //[textView becomeFirstResponder];
    [self.view addSubview:textView];
    self.textView = textView;
}
/**
 *  键盘顶部的工具条设置
 */
- (void)setupToolbar
{
    LSPAddTagToobar *toolbar = [LSPAddTagToobar viewFromXib];
    
    toolbar.y = self.view.height - toolbar.height;
    toolbar.width = self.view.width;
    
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    //监听键盘弹出的通知
    [LSPNotiCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)postWord
{
    LSPLog(@"右侧按钮的点击事件");
}
- (void)keyboardWillChangeFrame:(NSNotification *)noti
{
    //键盘最终的Frame
    CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //动画持续时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, keyboardFrame.origin.y - LSPScreenH);
    }];
    
}
#pragma mark--UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{//当有文字发生改变的时候，发布按钮可以被点击
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
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
