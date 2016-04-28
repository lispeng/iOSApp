//
//  LSPCommentCell.m
//  百思不得姐
//
//  Created by mac on 16-4-8.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//评论内容的cell

#import "LSPCommentCell.h"
#import "LSPComment.h"
#import "LSPUser.h"
#import "UIImageView+WebCache.h"
@interface LSPCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIImageView *sexView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation LSPCommentCell

- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}
- (void)awakeFromNib
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = imageView;
//    self.autoresizingMask = UIViewAutoresizingNone;
//    self.text_Label.autoresizingMask = UIViewAutoresizingNone;
}


- (void)setComment:(LSPComment *)comment
{
    _comment = comment;
    //用户头像
    [self.profileImageView setCircleHeader:comment.user.profile_image];
    //性别显示
    self.sexView.image = [comment.user.sex isEqualToString:LSPUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    //评论内容
    self.contentLabel.text = comment.content;
    //用户名字
    self.usernameLabel.text = comment.user.username;
    //点赞数量
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd\"",comment.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = LSPTopicCellMargin;
    frame.size.width -= 2 * LSPTopicCellMargin;
    
    [super setFrame:frame];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
