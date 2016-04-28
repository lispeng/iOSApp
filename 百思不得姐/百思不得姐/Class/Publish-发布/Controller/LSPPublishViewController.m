//
//  LSPPublishViewController.m
//  百思不得姐
//
//  Created by mac on 16-3-28.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPPublishViewController.h"
#import "LSPVerticalButton.h"
#import <POP.h>
#import "LSPPostWordViewController.h"
#import "LSPNavigationController.h"
static CGFloat const animDelay = 0.1;
static CGFloat const LSPSpringFactor = 10.0;
@interface LSPPublishViewController ()

@end

@implementation LSPPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化子控件
    [self setupPublishChildView];
    // Do any additional setup after loading the view from its nib.
}
/**
 *  初始化控制器内部的子控件
 */
- (void)setupPublishChildView
{
    //弹簧动画下降的过程中按钮不能被点击
    self.view.userInteractionEnabled = NO;
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];

    //中间六个按钮设置
    int maxCols = 3;
    CGFloat publishBtnW = 72;
    CGFloat publishBtnH = publishBtnW + 30;
    CGFloat publishBtnY = (LSPScreenH - 2 * publishBtnH) * 0.5;
    CGFloat publishStartX = 15;
    CGFloat xMargin = (LSPScreenW - 2 * publishStartX - 3 * publishBtnW) / (maxCols - 1);
    
    for (int i = 0; i < images.count; i ++) {
        LSPVerticalButton *publishBtn = [[LSPVerticalButton alloc] init];
        //publishBtn.width = publishBtnW;
        //publishBtn.height = publishBtnH;
        int row = i / maxCols;
        int col = i % maxCols;
       CGFloat publishBtnEndX = publishStartX + col * (publishBtnW + xMargin);
       CGFloat publishBtnEndY = publishBtnY + row * publishBtnH;
        CGFloat publishBtnBeginY = publishBtnEndY - LSPScreenH;
        //添加按钮动画
        POPSpringAnimation *springAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        springAnim.fromValue = [NSValue valueWithCGRect:CGRectMake(publishBtnEndX, publishBtnBeginY, publishBtnW, publishBtnH)];
        springAnim.toValue = [NSValue valueWithCGRect:CGRectMake(publishBtnEndX, publishBtnEndY, publishBtnW, publishBtnH)];
        springAnim.springBounciness = LSPSpringFactor;
        springAnim.springSpeed = LSPSpringFactor;
        //延迟时间执行动画
        springAnim.beginTime = CACurrentMediaTime() + animDelay * i;
        [publishBtn pop_addAnimation:springAnim forKey:nil];
     //设置按钮文字
        [publishBtn setTitle:titles[i] forState:UIControlStateNormal];
        publishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [publishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        publishBtn.tag = i;
        [publishBtn addTarget:self action:@selector(publishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:publishBtn];
        
    }
    //添加头部标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
//    sloganView.y = LSPScreenH * 0.2;
//    sloganView.centerX = LSPScreenW * 0.5;
    [self.view addSubview:sloganView];
     //头部标语的动画
    POPSpringAnimation *sloganAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    //中心点X/Y的计算
    CGFloat sloganCenterX = LSPScreenW * 0.5;
    CGFloat sloganEndCenterY = LSPScreenH * 0.2;
    CGFloat sloganBeginY = sloganEndCenterY - LSPScreenH;
    sloganView.centerY = sloganBeginY;
    sloganView.centerX = sloganCenterX;
    sloganAnim.beginTime = CACurrentMediaTime() + images.count * animDelay;
    sloganAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(sloganCenterX, sloganBeginY)];
    sloganAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(sloganCenterX, sloganEndCenterY)];
    //设置弹簧速率
    sloganAnim.springBounciness = LSPSpringFactor;
    sloganAnim.springSpeed = LSPSpringFactor;
    [sloganAnim setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
        //动画执行完毕按钮被点击
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:sloganAnim forKey:nil];
    
}

- (void)publishBtnClick:(UIButton *)button
{
    [self cancelWithCompletionBlock:^{
        if(button.tag == 2){//发段子
            //弹出发段子的控制器
            LSPPostWordViewController *postWordVC = [[LSPPostWordViewController alloc] init];
            LSPNavigationController *nav = [[LSPNavigationController alloc] initWithRootViewController:postWordVC];
            UIViewController *viewVC = [UIApplication sharedApplication].keyWindow.rootViewController;
            [viewVC presentViewController:nav animated:YES completion:nil];
            
        }
    }];
}
/**
 *  点击取消按钮
 */
- (IBAction)cancel
{
    [self cancelWithCompletionBlock:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self cancel];
}
/**
 *  先执行退出动画，动画完毕后执行completionBlock动作
 *
 *  @param completionBlock <#completionBlock description#>
 */
- (void)cancelWithCompletionBlock:(void(^)())completionBlock
{
    //让弹簧按钮不能被点击
    self.view.userInteractionEnabled = NO;
    int index = 2;
    for (int i = index; i < self.view.subviews.count; i ++) {
        //取出第一个子控件
        UIView *childView = self.view.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        //中心点X/Y的计算
        CGFloat CenterY = childView.centerY + LSPScreenH;
        
        anim.beginTime = CACurrentMediaTime() + (i - index) * animDelay;
        
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(childView.centerX, CenterY)];
        //设置弹簧速率
        //        anim.springBounciness = LSPSpringFactor;
        //        anim.springSpeed = LSPSpringFactor;
        //设置动画执行节奏
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [childView pop_addAnimation:anim forKey:nil];
        
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
                //动画执行完毕移除控制器
                [self dismissViewControllerAnimated:NO completion:nil];
                LSPLog(@"动画执行完毕");
                !completionBlock ? : completionBlock();
            }];
            
        }
        
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
