//
//  LSPCommentHeaderView.h
//  百思不得姐
//
//  Created by mac on 16-4-7.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSPCommentHeaderView : UITableViewHeaderFooterView
@property (copy,nonatomic) NSString *title;
+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView;
@end
