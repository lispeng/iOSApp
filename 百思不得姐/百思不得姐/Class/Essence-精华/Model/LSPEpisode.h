//
//  LSPEpisode.h
//  百思不得姐
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSPComment;
@interface LSPEpisode : NSObject
/**
 *  id
 */
@property (copy,nonatomic) NSString *ID;
/**
 *  昵称
 */
@property (copy,nonatomic) NSString *name;
/**
 *  头像URL
 */
@property (copy,nonatomic) NSString *profile_image;
/**
 *  发帖时间
 */
@property (copy,nonatomic) NSString *create_time;
/**
 *  帖子内容
 */
@property (copy,nonatomic) NSString *text;
/**
 *  顶的数量
 */
@property (nonatomic, assign) NSInteger ding;
/**
 *  踩的数量
 */
@property (nonatomic, assign) NSInteger cai;
/**
 *  转发的数量
 */
@property (nonatomic, assign) NSInteger repost;
/**
 *  评论的数量
 */
@property (nonatomic, assign) NSInteger comment;
/**
 *  是否是新浪加V认证
 */
@property (nonatomic, assign,getter=isSina_v) BOOL sina_v;
/**
 *  图片的宽度
 */
@property (assign,nonatomic) CGFloat width;
/**
 *  图片的宽度
 */
@property (assign,nonatomic) CGFloat height;
/**
 *  小图片的URL
 */
@property (copy,nonatomic) NSString *small_image;
/**
 *  大图片的URL
 */
@property (copy,nonatomic) NSString *large_image;
/**
 *  中等图片的URL
 */
@property (copy,nonatomic) NSString *middle_image;
/**
 *  段子类型
 */
@property (nonatomic, assign) LSPTopicType type;
/**
 *  音频时长
 */
@property (assign,nonatomic) NSInteger voicetime;
/**
 *  播放次数
 */
@property (assign,nonatomic) NSInteger playcount;
/**
 *  视频时长
 */
@property (assign,nonatomic) NSInteger videotime;
/**
 *  最热评论
 */
//@property (strong,nonatomic) NSArray *top_cmt;

@property (strong,nonatomic) LSPComment *top_cmt;

/*******************************************************/
/**
 *  额外的辅助属性
 */
@property (assign,nonatomic,readonly) CGFloat cellHeight;
/**
 *  图片控件的frame
 */
@property (assign,nonatomic,readonly) CGRect pictureViewFrame;
/**
 *  图片是否太大
 */
@property (assign,nonatomic,getter=isBigPicture) BOOL bigPicture;
/**
 *  图片的下载进度
 */
@property (assign,nonatomic) CGFloat pictureProgress;

/**
 *  声音控件的frame
 */
@property (assign,nonatomic,readonly) CGRect voiceFrame;

/**
 *  视频控件的frame
 */
@property (assign,nonatomic,readonly) CGRect videoFrame;

@end
