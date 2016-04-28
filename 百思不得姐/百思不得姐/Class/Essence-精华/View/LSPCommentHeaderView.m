//
//  LSPCommentHeaderView.m
//  百思不得姐
//
//  Created by mac on 16-4-7.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPCommentHeaderView.h"
@interface LSPCommentHeaderView()
/**
 *  文字控件
 */
@property (nonatomic,weak) UILabel *label;

@end
@implementation LSPCommentHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = LSPBackgroundColor;
        UILabel *cellHeaderLabel = [[UILabel alloc] init];
        
        cellHeaderLabel.textColor = LSPColor(67, 67, 67);
        cellHeaderLabel.x = LSPTopicCellMargin;
        cellHeaderLabel.width = 200;
        cellHeaderLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:cellHeaderLabel];
        self.label = cellHeaderLabel;
    }
    return self;
}
- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.label.text = title;
}
+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    LSPCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (nil == header) {
        header = [[LSPCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    return header;
}
@end
