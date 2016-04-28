//
//  LSPComment.h
//  百思不得姐
//
//  Created by mac on 16-4-6.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSPUser;
@interface LSPComment : NSObject
/**
 *  id
 */
@property (copy,nonatomic) NSString *ID;
/**
 *  音频时长
 */
@property (nonatomic, assign) NSInteger voicetime;
/**
 *  音频的URL路径
 */
@property (copy,nonatomic) NSString *voiceuri;
/**
 *  评论的文字内容
 */
@property (copy,nonatomic) NSString *content;
/**
 *  点赞的数量
 */
@property (assign,nonatomic) NSInteger like_count;
/**
 *  用户
 */
@property (strong,nonatomic) LSPUser *user;
@end
