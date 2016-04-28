//
//  LSPTopicPictureView.h
//  百思不得姐
//
//  Created by mac on 16-3-25.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//图片帖子中间的内容

#import <UIKit/UIKit.h>
@class LSPEpisode;
@interface LSPTopicPictureView : UIView

+ (instancetype)pictureView;

@property (strong,nonatomic) LSPEpisode *topic;

@end
