//
//  LSPVerticalButton.m
//  百思不得姐
//
//  Created by mac on 16-2-19.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPVerticalButton.h"

@implementation LSPVerticalButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
/**
 *  布局按钮内部的子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    //调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.imageView.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
