//
//  LSPTopicVideoView.h
//  百思不得姐
//
//  Created by mac on 16-4-5.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSPEpisode;
@interface LSPTopicVideoView : UIView
@property (strong,nonatomic) LSPEpisode *topic;
+ (instancetype)videoView;
@end
