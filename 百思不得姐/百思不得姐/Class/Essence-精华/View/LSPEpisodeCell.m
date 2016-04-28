//
//  LSPEpisodeCell.m
//  百思不得姐
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPEpisodeCell.h"
#import "UIImageView+WebCache.h"
#import "LSPEpisode.h"
#import "LSPTopicPictureView.h"
#import "LSPTopicVoiceView.h"
#import "LSPTopicVideoView.h"
#import "LSPComment.h"
#import "LSPUser.h"
@interface LSPEpisodeCell()
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  创建时间
 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/**
 *  顶
 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/**
 *  踩
 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/**
 *  分享
 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/**
 *  评论
 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/**
 *  新浪加V认证
 */
@property (weak, nonatomic) IBOutlet UIImageView *sina_VView;

/**
 *  帖子文字内容
 */
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
/**
 *  图片帖子中间的图片内容
 */
@property (nonatomic,weak) LSPTopicPictureView *pictureView;
/**
 *  声音帖子中间的图片内容
 */
@property (nonatomic,weak) LSPTopicVoiceView *voiceView;
/**
 *  视频帖子的内容
 */
@property (nonatomic,weak) LSPTopicVideoView *videoView;
/**
 *  最热评论内容
 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/**
 *  最热评论整体
 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@end

@implementation LSPEpisodeCell
/**
 *  调用此方法创建LSPEpisodeCell对象
 *
 */
+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
/**
 *  图片帖子
 *
 *  @return <#return value description#>
 */
- (LSPTopicPictureView *)pictureView
{
    if (_pictureView == nil) {
       LSPTopicPictureView *pictureView = [LSPTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
/**
 *  声音帖子
 *
 *  @return <#return value description#>
 */
- (LSPTopicVoiceView *)voiceView
{
    if (_voiceView == nil) {
        LSPTopicVoiceView *voiceView = [LSPTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (LSPTopicVideoView *)videoView
{
    if (nil == _videoView) {
        LSPTopicVideoView *videoView = [LSPTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}
- (void)awakeFromNib
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = imageView;
    self.autoresizingMask = UIViewAutoresizingNone;
    self.text_Label.autoresizingMask = UIViewAutoresizingNone;
}
- (void)setTopic:(LSPEpisode *)topic
{
    _topic = topic;
    //测试加V认证
    //topic.sina_v = arc4random_uniform(100) % 2;
    //头像
    [self.profileImageView setCircleHeader:topic.profile_image];
    //新浪加V认证处理
    self.sina_VView.hidden = !topic.sina_v;
    //昵称
    self.nameLabel.text = topic.name;
    
    //发帖时间
       self.createTimeLabel.text = topic.create_time;
    //根据帖子的类型添加对应的内容到cell中间
    if (topic.type == LSPTopicTypeIllustration)//图片帖子
    {
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureViewFrame;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (topic.type == LSPTopicTypeVoice)//声音帖子
    {
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceFrame;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }
    else if (topic.type == LSPTopicTypeVideo)//视频帖子
    {
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoFrame;
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }
    else//段子帖子
    {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    //处理最热评论
   // LSPComment *comment = [topic.top_cmt firstObject];
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",topic.top_cmt.user.username,topic.top_cmt.content];
    }else{
        self.topCmtView.hidden = YES;
    }
    
    
    //底部工具条的处理
    [self setupButton:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButton:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButton:self.commentButton count:topic.comment placeholder:@"评论"];
    //设置帖子的文字内容
    
    self.text_Label.text = topic.text;
   // self.text_Label.backgroundColor = [UIColor orangeColor];
}
/**
 *  数据处理
 *
 */
- (void)setupButton:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f",count / 10000.0];
    }else if(count > 0)
    {
       placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    
    [button setTitle:placeholder forState:UIControlStateNormal];
}
/**
 *  设置cell的位置
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = LSPTopicCellMargin;
    frame.origin.y += LSPTopicCellMargin;
    frame.size.width -= LSPTopicCellMargin * 2;
   // frame.size.height -= LSPTopicCellMargin;
    frame.size.height = self.topic.cellHeight - LSPTopicCellMargin;
    [super setFrame:frame];
}
/**
 *  加关注
 */
- (IBAction)moreBtnClick {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏","举报", nil];
    [sheet showInView:self.window];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
