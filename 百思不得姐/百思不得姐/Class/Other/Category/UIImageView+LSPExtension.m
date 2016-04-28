//
//  UIImageView+LSPExtension.m
//  百思不得姐
//
//  Created by mac on 16-4-11.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "UIImageView+LSPExtension.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (LSPExtension)
- (void)setCircleHeader:(NSString *)url
{
    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
        
    }];

}
@end
