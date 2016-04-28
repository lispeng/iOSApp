//
//  LSPRecommendUserCell.m
//  百思不得姐
//
//  Created by mac on 16-2-17.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPRecommendUserCell.h"
#import "LSPRecommendUser.h"
#import "UIImageView+WebCache.h"
@interface LSPRecommendUserCell()
/**
 *  用户头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconHeader;
/**
 *  用户昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *userName;
/**
 *  用户粉丝数
 */
@property (weak, nonatomic) IBOutlet UILabel *userFansCount;


@end
@implementation LSPRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(LSPRecommendUser *)user
{
    _user = user;
    [self.iconHeader setCircleHeader:user.header];

    self.userName.text = user.screen_name;
    NSString *fansCount = nil;
    if(user.fans_count < 10000)
    {
        fansCount = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    }else{
        fansCount = [NSString stringWithFormat:@"%.1f万人关注",user.fans_count / 10000.0];
    }
    self.userFansCount.text = fansCount;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
