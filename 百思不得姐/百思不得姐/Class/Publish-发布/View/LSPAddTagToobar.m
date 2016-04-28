//
//  LSPAddTagToobar.m
//  百思不得姐
//
//  Created by mac on 16-4-13.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPAddTagToobar.h"
#import "LSPAddTagViewController.h"
@interface LSPAddTagToobar()
/**
 *  顶部的控件
 */
@property (weak, nonatomic) IBOutlet UIView *topView;
/**
 *  存放所有标签的label
 */
@property (strong,nonatomic) NSMutableArray *tagLabels;
/**
 *  添加按钮
 */
@property (nonatomic,weak) UIButton *addButton;

@end
@implementation LSPAddTagToobar
- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}
+ (instancetype)toolbar
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    //控件右边的添加按钮
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addButton.size = addButton.currentImage.size;
    addButton.x = LSPTagMargin;
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:addButton];
    self.addButton = addButton;
    //开始的两个标签
    [self createTagLabel:@[@"吐槽",@"糗事"]];
}
- (void)addButtonClick
{
    LSPAddTagViewController *addTagVC = [[LSPAddTagViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    [addTagVC setTagsBlock:^(NSArray *tags) {
        [weakSelf createTagLabel:tags];
        NSLog(@"addTagVC.tags = %@",tags);
    }];
    addTagVC.tags = [self.tagLabels valueForKeyPath:@"text"];
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)rootVC.presentedViewController;
    [nav pushViewController:addTagVC animated:YES];
}
- (void)createTagLabel:(NSArray *)tags
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i < tags.count; i ++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        tagLabel.text = tags[i];
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.font = LSPTagFont;
        [tagLabel sizeToFit];
        tagLabel.width += 2 * LSPTagMargin;
        tagLabel.height = LSPTagHeight;        
        tagLabel.backgroundColor = LSPTagBg;
        tagLabel.textColor = [UIColor whiteColor];
        [self.topView addSubview:tagLabel];
        [self.tagLabels addObject:tagLabel];
        }
    //重新布局子控件
    [self setNeedsLayout];
    
            
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < self.tagLabels.count; i ++) {
        
        UILabel *tagLabel = self.tagLabels[i];
       
        //位置设置
        //UILabel *tagLabel = self.tagLabels[i];
        if (0 == i) {//第一个标签按钮
            tagLabel.x = 0;
            tagLabel.y = 0;
        }else{
            
            //获取上一个按钮
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            //计算左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + LSPTagMargin;
            //计算右边的宽度
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= tagLabel.width) {//显示在当前行
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            }else{//显示在下一行
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + LSPTagMargin;
                
            }
            
        }
        
        
    }
    //取出最后一个按钮
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + LSPTagMargin;
    if (self.topView.width - leftWidth  >= self.addButton.width) {
        
        self.addButton.x = leftWidth;
        self.addButton.y = lastTagLabel.y;
        
    }else{
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + LSPTagMargin;
    }
    
    
    //toolbar自身的整体高度
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame) + 40;
    self.y -= self.height - oldH;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
