//
//  LSPTagTextField.m
//  百思不得姐
//
//  Created by mac on 16-4-14.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPTagTextField.h"

@implementation LSPTagTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或换行隔开";
        //设置占位文字的颜色
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = LSPTagHeight;

    }
    return self;
}
/**
 *  点击删除按钮
 */
- (void)deleteBackward
{
    !self.deleteBlock ? : self.deleteBlock();

    [super deleteBackward];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
