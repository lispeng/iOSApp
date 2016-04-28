//
//  LSPRecommendUserCell.h
//  百思不得姐
//
//  Created by mac on 16-2-17.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSPRecommendUser;
@interface LSPRecommendUserCell : UITableViewCell
/**
 *  用户模型
 */
@property (strong,nonatomic) LSPRecommendUser *user;
@end
