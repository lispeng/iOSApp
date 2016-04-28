//
//  LSPProgressView.m
//  百思不得姐
//
//  Created by mac on 16-3-27.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPProgressView.h"

@implementation LSPProgressView

- (void)awakeFromNib
{
    //设置进度条圆角类型
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
     self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@"" ];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
