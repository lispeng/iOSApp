//
//  LSPUser.h
//  百思不得姐
//
//  Created by mac on 16-4-6.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSPUser : NSObject
/**
 *  用户名
 */
@property (copy,nonatomic) NSString *username;
/**
 *  用户头像
 */
@property (copy,nonatomic) NSString *profile_image;
/**
 *  用户性别
 */
@property (copy,nonatomic) NSString *sex;

@end
