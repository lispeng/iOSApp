//
//  LSPTagTextField.h
//  百思不得姐
//
//  Created by mac on 16-4-14.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSPTagTextField : UITextField
/**
 *  按了删除键的处理
 */
@property (copy,nonatomic) void(^deleteBlock)();
@end
