//
//  LSPRecommendCategoryCell.m
//  百思不得姐
//
//  Created by mac on 16-2-17.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPRecommendCategoryCell.h"
#import "LSPRecommendCategory.h"

@interface LSPRecommendCategoryCell()
/**
 *  选中cell时会出现的左侧指示器
 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end

@implementation LSPRecommendCategoryCell

- (void)awakeFromNib {
    // Initialization code
    //设置cell的背景色
    self.backgroundColor = LSPColor(244, 244, 244);
    //设置选中的指示器的背景颜色
    self.selectedIndicator.backgroundColor = LSPColor(219, 21, 26);
      //设置cell在被点击的时候不会变成高亮的背景色
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.frame = self.bounds;
    self.selectedBackgroundView = bgView;
    self.textLabel.font = [UIFont systemFontOfSize:13];
   
}
- (void)setCategory:(LSPRecommendCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
   
}
/**
 *  选中tableView的cell时会调用的方法
 *
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    //指示器在没有被选中的时候会被隐藏
    self.selectedIndicator.hidden = !selected;
    //设置文字在被选中的时候显示的颜色
    self.textLabel.textColor = selected ? LSPColor(219, 21, 26) : LSPColor(78, 78, 78);
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置cell内部的textLabel的布局
    self.textLabel.y = 2;
    self.textLabel.height = self.height - 2 * self.textLabel.y;
  
}


@end
