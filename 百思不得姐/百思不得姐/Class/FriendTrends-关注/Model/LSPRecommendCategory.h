//
//  LSPRecommendCategory.h
//  百思不得姐
//
//  Created by mac on 16-2-17.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSPRecommendCategory : NSObject
/**
 *  id
 */
@property (assign,nonatomic) NSInteger id;
/**
 *  总数
 */
@property (nonatomic, assign) NSInteger count;
/**
 *  名字
 */
@property (copy,nonatomic) NSString *name;

/**
 *  存储所有用户的数据
 */
@property (strong,nonatomic) NSMutableArray *users;
/**
 *  总页数
 */
@property (assign,nonatomic) NSInteger total_page;
/**
 *  数据总数
 */
@property (assign,nonatomic) NSInteger total;
/**
 *  下一页
 */
@property (assign,nonatomic) NSInteger next_page;
/**
 *  当前页码
 */
@property (nonatomic, assign) NSInteger currentPage;
@end
