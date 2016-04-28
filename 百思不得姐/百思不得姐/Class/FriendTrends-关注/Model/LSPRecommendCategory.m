//
//  LSPRecommendCategory.m
//  百思不得姐
//
//  Created by mac on 16-2-17.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPRecommendCategory.h"

@implementation LSPRecommendCategory
- (NSMutableArray *)users
{
    if (_users == nil) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
