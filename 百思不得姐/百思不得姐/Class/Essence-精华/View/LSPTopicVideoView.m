//
//  LSPTopicVideoView.m
//  百思不得姐
//
//  Created by mac on 16-4-5.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPTopicVideoView.h"
#import "LSPEpisode.h"
#import "UIImageView+WebCache.h"
#import "LSPShowPictureViewController.h"
@interface LSPTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;


@end

@implementation LSPTopicVideoView
+ (instancetype)videoView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTopic:(LSPEpisode *)topic
{
    _topic = topic;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    //播放时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
}

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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
