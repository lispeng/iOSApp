//
//  LSPTopicPictureView.m
//  百思不得姐
//
//  Created by mac on 16-3-25.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPTopicPictureView.h"
#import "LSPEpisode.h"
#import "UIImageView+WebCache.h"
#import "LSPProgressView.h"
#import "LSPShowPictureViewController.h"
@interface LSPTopicPictureView()
/**
 *  图片内容
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**
 *  gif图片标识
 */
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
/**
 *  查看大图的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
/**
 *  进度条控件
 */

@property (weak, nonatomic) IBOutlet LSPProgressView *progressView;

@end
@implementation LSPTopicPictureView
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
   
    //给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPicture)];
    [self.imageView addGestureRecognizer:tap];
}
/**
 *  点击显示大图片的方法
 */
- (void)showBigPicture
{
    LSPShowPictureViewController *showPicture = [[LSPShowPictureViewController alloc] init];
    //传递数据模型以便进行相应的数据处理
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}
+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTopic:(LSPEpisode *)topic
{
    _topic = topic;
    //立马显示最新的进度值(防止因为网速慢而显示其他cell复用过来的的图片下载进度)
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //显示下载图片的进度条
         self.progressView.hidden = NO;
        //计算进度值
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        //显示进度值
        [self.progressView setProgress:topic.pictureProgress animated:NO];
       
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //下载完图片后进度条要隐藏
        self.progressView.hidden = YES;
        //图片处理过大的图片显示顶部(如果是大图片才需要处理)
        if (topic.isBigPicture == NO) return;
        
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureViewFrame.size, YES, 0.0);
        //将图片画到当前图形上下文当中
        CGFloat imageW = topic.pictureViewFrame.size.width;
        //显示宽度  显示高度(X)
        //实际宽度  实际高度
        CGFloat imageH = imageW * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
        
        //获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        //结束图形上下文
        UIGraphicsEndImageContext();
        
        
        

    }];
    //获取文件路径扩展名
    NSString *extension = topic.large_image.pathExtension;
    //判断图片是否是gif格式，根据需要来显示gif图标
    self.gifImageView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    [self insertSubview:self.gifImageView aboveSubview:self.imageView];
    //点击查看全图的按钮是否显示
    [self insertSubview:self.seeBigButton aboveSubview:self.imageView];
    self.seeBigButton.hidden = !topic.bigPicture;
    if(topic.bigPicture == YES){//是大图
        self.seeBigButton.hidden = NO;
        //只显示一部分图片
       // self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{//不是大图
        self.seeBigButton.hidden = YES;
        //self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
}
@end
