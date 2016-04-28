//
//  LSPRecommendUser.h
//  百思不得姐
//
//  Created by mac on 16-2-17.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSPRecommendUser : NSObject
/**
 *  头像
 */
@property (copy,nonatomic) NSString *header;
/**
 *  粉丝数（有多少人在关注这个用户）
 */
@property (assign,nonatomic) NSInteger fans_count;
/**
 *  昵称
 */
@property (copy,nonatomic) NSString *screen_name;


@end
