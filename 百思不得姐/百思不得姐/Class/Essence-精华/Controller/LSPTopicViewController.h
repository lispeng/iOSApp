//
//  LSPTopicViewController.h
//  百思不得姐
//
//  Created by mac on 16-3-24.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LSPTopicViewController : UITableViewController
/**
 *  帖子类型交给子类实现
 */
@property (nonatomic, assign) LSPTopicType type;
//- (NSString *)type;
@end
