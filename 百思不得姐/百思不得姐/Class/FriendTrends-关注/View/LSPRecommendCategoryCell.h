//
//  LSPRecommendCategoryCell.h
//  百思不得姐
//
//  Created by mac on 16-2-17.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSPRecommendCategory;
@interface LSPRecommendCategoryCell : UITableViewCell
/**
 *  左侧的类别模型
 */
@property (strong,nonatomic) LSPRecommendCategory *category;
@end
