//
//  LSPShowPictureViewController.m
//  百思不得姐
//
//  Created by mac on 16-3-27.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//显示大图的控制器界面

#import "LSPShowPictureViewController.h"
#import "LSPEpisode.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "LSPProgressView.h"
#import <POP.h>
@interface LSPShowPictureViewController ()
/**
 *  背景scrollView
 */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/**
 *  大图片的显示控件
 */
@property (nonatomic,weak) UIImageView *imageView;
/**
 *  进度条控件
 */
@property (weak, nonatomic) IBOutlet LSPProgressView *progressView;

@end

@implementation LSPShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //显示预览大图片
    [self previewBigImage];
    // Do any additional setup after loading the view from its nib.
}
- (void)previewBigImage
{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    //添加点击事件
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [imageView addGestureRecognizer:tap];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    //显示预览大图片的frame处理
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    
    if (pictureH > screenH) {//显示出的图片的高度大于屏幕的高度
        
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{//显示的图片高度不大于屏幕的高度
        
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH * 0.5;
        
    }
    //立马显示当前的下载进度
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    //下载图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        //设置进度值
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}
- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  保存图片
 */
- (IBAction)saveImage {
    
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片还没下载完成"];
        return;
    }
    //将图片保存到相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
/**
 *  保存图片成功
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    }else{
    [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}
/**
 *  转发图片
 */
- (IBAction)repeatImage {
    
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
