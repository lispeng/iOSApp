//
//  LSPAddTagViewController.h
//  百思不得姐
//
//  Created by mac on 16-4-13.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSPAddTagViewController : UIViewController
/**
 *  获取tags的block
 */
@property (copy,nonatomic) void (^tagsBlock)(NSArray *tags);
/**
 *  所有的标签
 */
@property (strong,nonatomic) NSArray *tags;
@end
