//
//  LSPConst.h
//  百思不得姐
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    LSPTopicTypeAll = 1,//全部
    LSPTopicTypeVideo = 41,//视频
    LSPTopicTypeVoice = 31,//音频
    LSPTopicTypeIllustration = 10,//插图
    LSPTopicTypeEpisode = 29//段子
}LSPTopicType;

/**
 *  精华页面顶部标题的高度
 */
UIKIT_EXTERN CGFloat const LSPTitlesViewH;
/**
 *  精华页面顶部标题的Y坐标
 */
UIKIT_EXTERN CGFloat const LSPTitlesViewY;
/**
 *  精华页面cell的间距
 */
UIKIT_EXTERN CGFloat const LSPTopicCellMargin;
/**
 *  精华页面cell文字内容的Y值
 */
UIKIT_EXTERN CGFloat const LSPTopicCellTextY;
/**
 *  精华页面cell的底部工具条高度
 */
UIKIT_EXTERN CGFloat const LSPTopicCellBottomBarH;
/**
 *  精华页面cell图片帖子的最大高度
 */
UIKIT_EXTERN CGFloat const LSPTopicCellPictureMaxH;
/**
 *  精华页面cell图片帖子的超出最大高度时设定固定高度
 */
UIKIT_EXTERN CGFloat const LSPTopicCellPictureFixedH;
/**
 *  精华页面最热评论标题的高度
 */
UIKIT_EXTERN CGFloat const LSPTopicCellCmtTitleH;

/**
 *  LSPUser-模型的性别属性值
 */
UIKIT_EXTERN NSString *const LSPUserSexMale;
UIKIT_EXTERN NSString *const LSPUserSexFemale;

/**
 *  tabBar被选中的通知的名字
 */
UIKIT_EXTERN NSString *const LSPTabBarDidSelectNotification;
/**
 *  tabBar被选中的控制器的索引index--->key
 */
UIKIT_EXTERN NSString *const LSPSelectControllerIndexKey;
/**
 *  tabBar被选中的控制器的key
 */
UIKIT_EXTERN NSString *const LSPSelectControllerKey;
/**
 *  标签的间距
 */
UIKIT_EXTERN CGFloat const LSPTagMargin;
/**
 *  标签的高度
 */
UIKIT_EXTERN CGFloat const LSPTagHeight;

