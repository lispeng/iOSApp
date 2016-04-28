//
//  LSPPushGuideView.h
//  百思不得姐
//
//  Created by mac on 16-3-25.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSPPushGuideView : UIView
/**
 *  加载nib文件
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedGuideView;

/**
 *  显示引导页的方法
 */
+ (void)showGuidePage;
@end
