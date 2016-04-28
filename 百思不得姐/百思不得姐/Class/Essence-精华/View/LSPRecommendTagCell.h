//
//  LSPRecommendTagCell.h
//  百思不得姐
//
//  Created by mac on 16-2-18.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSPRecommendTag;
@interface LSPRecommendTagCell : UITableViewCell
/**
 *  推荐标签的模型
 */
@property (strong,nonatomic) LSPRecommendTag *recommendTag;
@end
