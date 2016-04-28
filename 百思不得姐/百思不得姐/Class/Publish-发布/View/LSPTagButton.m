//
//  LSPTagButton.m
//  百思不得姐
//
//  Created by mac on 16-4-14.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPTagButton.h"

@implementation LSPTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = LSPTagBg;
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    self.width += 3 * LSPTagMargin;
    self.height = LSPTagHeight;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = LSPTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + LSPTagMargin;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
