//
//  LSPMeCell.m
//  百思不得姐
//
//  Created by mac on 16-4-11.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPMeCell.h"

@implementation LSPMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //带箭头指示器的cell
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //设置背景图片
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = imageView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (void)layoutSubviews
{
   
    [super layoutSubviews];
    
     if(nil ==self.imageView.image) return;
    self.imageView.width = 30;
    self.imageView.height = self.imageView.height;
    self.imageView.centerY = self.contentView.height * 0.5;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + LSPTopicCellMargin;
    
}
//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y -= (35 - LSPTopicCellMargin);
//    [super setFrame:frame];
//}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
