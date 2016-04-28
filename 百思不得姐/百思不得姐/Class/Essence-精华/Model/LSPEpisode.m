//
//  LSPEpisode.m
//  百思不得姐
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPEpisode.h"
#import "MJExtension.h"
#import "LSPComment.h"
#import "LSPUser.h"

@implementation LSPEpisode
{
    CGFloat _cellHeight;
    CGRect _pictureViewFrame;
}
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
              @"large_image" : @"image1",
              @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"//top_cmt数组中的第0个元素
             };
}
/**
 *  top_cmt数组里面装的是LSPCommment模型，不再是字典
 *
 *  @return <#return value description#>
 */
/*
+ (NSDictionary *)objectClassInArray
{
    return @{@"top_cmt" : @"LSPComment"};
}
 */
- (NSString *)create_time
{
    
    //获取当前时间
    NSDate *now = [NSDate date];
    //日期格式化
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期解析格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //解析日期
    NSDate *createDate = [fmt dateFromString:_create_time];

    //日期时间处理
    if (createDate.isThisYear) {//是今年发的帖子
        if(createDate.isThisToday)//是今天
        {
            NSDateComponents *cmps = [now dateComponentsWithFrom:createDate];
            if (cmps.hour >= 1) {//大于1小时
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >= 1)//大于1分钟
            {
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{//1分钟内
                return @"刚刚";
            }
        }else if(createDate.isThisYesterday)//是昨天
        {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createDate];
        }else{//既非今天也非昨天
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createDate];
        }
        
        
    }else{//不是今年发的帖子
        return _create_time;
    }

}
/**
 *  文字内容的高度计算
 *
 *  
 */
- (CGFloat)cellHeight
{
    //加上判断，避免重复计算cell的高度
    if(!_cellHeight){
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * LSPTopicCellMargin, MAXFLOAT);
    CGFloat textHeight = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        //文字部分的高度
    _cellHeight = LSPTopicCellTextY + textHeight + LSPTopicCellMargin;
        
        if(self.type == LSPTopicTypeIllustration)//插图
        {
            //图片显示的尺寸处理
            CGFloat pictureW = maxSize.width;//显示出的图片宽度
            //根据比例计算显示出的图片高度
            CGFloat pictureH = pictureW * self.height / self.width;
            //如果图片高度大于给定的临界值,就必须缩短到一个给定的固定值
            if (pictureH >= LSPTopicCellPictureMaxH) {
                pictureH = LSPTopicCellPictureFixedH;
                self.bigPicture = YES;
            }
            //计算图片控件的frame
            CGFloat pictureX = LSPTopicCellMargin;
            CGFloat pictureY = LSPTopicCellTextY + textHeight + LSPTopicCellMargin;
            _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            //图片的高度
            _cellHeight += pictureH + LSPTopicCellMargin;
        }
        else if (self.type == LSPTopicTypeEpisode)//文字内容
        {
            //_cellHeight += LSPTopicCellMargin;
        }
        else if (self.type == LSPTopicTypeVoice)//声音帖子
        {
            CGFloat voiceX = LSPTopicCellMargin;
            CGFloat voiceY = LSPTopicCellTextY + textHeight + LSPTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHeight += voiceH + LSPTopicCellMargin;
        }
        else if(self.type == LSPTopicTypeVideo)//视频帖子
        {
            CGFloat videoX = LSPTopicCellMargin;
            CGFloat videoY = LSPTopicCellTextY + textHeight + LSPTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoFrame = CGRectMake(videoX, videoY, videoW, videoH);
            _cellHeight += videoH + LSPTopicCellMargin;
        }
       //如果有最热评论
       // LSPComment *cmt = [self.top_cmt firstObject];
        if (self.top_cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@",self.top_cmt.user.username,self.top_cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += LSPTopicCellCmtTitleH + contentH + LSPTopicCellMargin;
        }
        
        //底部工具条的高度
        _cellHeight += LSPTopicCellBottomBarH + LSPTopicCellMargin;
    }
    return _cellHeight;
}
@end
