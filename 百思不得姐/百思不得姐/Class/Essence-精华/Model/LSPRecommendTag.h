//
//  LSPRecommendTag.h
//  百思不得姐
//
//  Created by mac on 16-2-18.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSPRecommendTag : NSObject
/**
 *  图片
 */
@property (copy,nonatomic) NSString *image_list;
/**
 *  名字
 */
@property (copy,nonatomic) NSString *theme_name;
/**
 *  订阅数
 */
@property (nonatomic, assign) NSInteger sub_number;
@end
