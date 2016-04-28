//
//  LSPRecommendTagCell.m
//  百思不得姐
//
//  Created by mac on 16-2-18.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPRecommendTagCell.h"
#import "LSPRecommendTag.h"
#import "UIImageView+WebCache.h"
@interface LSPRecommendTagCell()
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
/**
 *  名字
 */
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
/**
 *  订阅数
 */
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;


@end

@implementation LSPRecommendTagCell

- (void)setRecommendTag:(LSPRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    [self.imageListImageView setCircleHeader:recommendTag.image_list];
    
    self.themeNameLabel.text = recommendTag.theme_name;
    NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {//小于10000
        subNumber = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }else{
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNumber;
}
/**
 *  在这个方法中调整cell的尺寸，显示出分割线和左右间距
 *
 *  @param frame <#frame description#>
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= frame.origin.x * 2;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
