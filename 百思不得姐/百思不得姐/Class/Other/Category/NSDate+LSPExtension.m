//
//  NSDate+LSPExtension.m
//  百思不得姐
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "NSDate+LSPExtension.h"

@implementation NSDate (LSPExtension)
- (NSDateComponents *)dateComponentsWithFrom:(NSDate *)fromDate
{
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
  NSDateComponents *components = [[NSCalendar currentCalendar] components:unit fromDate:self toDate:fromDate options:0];
    return components;
}
- (BOOL)isThisYear
{
    //获取当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获取年进行比较
   NSInteger thisYear =[calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger otherYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return thisYear == otherYear;
}
- (BOOL)isThisYesterday;

{
    //获取当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获取天进行比较
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置时间格式
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *thisDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *otherDate = [fmt dateFromString:[fmt stringFromDate:self]];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:otherDate toDate:thisDate options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}
- (BOOL)isThisToday
{
    //获取当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获取天来进行比较
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *thisCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *otherCmps = [calendar components:unit fromDate:self];
    
    return thisCmps.year == otherCmps.year && thisCmps.month == otherCmps.month && thisCmps.day == otherCmps.day;
    
}
@end
