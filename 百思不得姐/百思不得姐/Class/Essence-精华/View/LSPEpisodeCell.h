//
//  LSPEpisodeCell.h
//  百思不得姐
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSPEpisode;
@interface LSPEpisodeCell : UITableViewCell
@property (strong,nonatomic) LSPEpisode *topic;
/**
 *  调用此方法创建LSPEpisodeCell对象
 *
 */
+ (instancetype)cell;
@end
