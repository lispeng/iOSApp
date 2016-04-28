//
//  NSDate+LSPExtension.h
//  百思不得姐
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LSPExtension)
/**
 *  日期比较方法,返回两个时间的比较差值
 *
 */
- (NSDateComponents *)dateComponentsWithFrom:(NSDate *)fromDate;
/**
 *  是否为今年
 *
 */
- (BOOL)isThisYear;
/**
 *  是否是昨天
 *
 *
 */
- (BOOL)isThisYesterday;
/**
 *  是否是今天
 *
 *  
 */
- (BOOL)isThisToday;
@end
