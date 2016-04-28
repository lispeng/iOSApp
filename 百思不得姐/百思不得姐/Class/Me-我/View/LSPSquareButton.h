//
//  LSPSquareButton.h
//  百思不得姐
//
//  Created by mac on 16-4-11.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSPSquare;
@interface LSPSquareButton : UIButton
/**
 *  方块按钮的模型属性
 */
@property (strong,nonatomic) LSPSquare *square;
@end
