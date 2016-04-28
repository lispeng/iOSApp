//
//  LSPAddTagViewController.m
//  百思不得姐
//
//  Created by mac on 16-4-13.
//  Copyright (c) 2016年 Lispeng. All rights reserved.
//

#import "LSPAddTagViewController.h"
#import "LSPTagButton.h"
#import "LSPTagTextField.h"
#import "SVProgressHUD.h"
@interface LSPAddTagViewController ()<UITextFieldDelegate>
/**
 *  背景View
 */
@property (strong,nonatomic) UIView *contentView;
/**
 *  文本输入框
 */
@property (nonatomic,weak) LSPTagTextField *textField;
/**
 *  添加按钮
 */
@property (nonatomic,weak) UIButton *addButton;
/**
 *  所有的标签按钮
 */
@property (strong,nonatomic) NSMutableArray *tagButtons;
@end

@implementation LSPAddTagViewController

- (UIView *)contentView
{
    if (!_contentView) {
        
        UIView *contentView = [[UIView alloc] init];
        [self.view addSubview:contentView];
        self.contentView = contentView;

    }
    return _contentView;
}

- (LSPTagTextField *)textField
{
    if (!_textField) {
        
        __weak typeof(self) weakSelf = self;
        LSPTagTextField *textField = [[LSPTagTextField alloc] init];
        textField.deleteBlock = ^{
            if(weakSelf.textField.hasText) return;
            [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
        };
        
        textField.delegate = self;
        [textField becomeFirstResponder];
        [textField addTarget:self action:@selector(textDidChanged) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:textField];
        self.textField = textField;

    }
    return _textField;
}
- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}
- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.height = 35;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.backgroundColor = LSPTagBg;
        //按钮控件的文字和图片向左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, LSPTagMargin, 0, LSPTagMargin);
        addButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:addButton];
        _addButton = addButton;
    }
    return _addButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAddTagNavigationBar];
    
    //输入框控件
    //[self setupTextField];
   
    // Do any additional setup after loading the view.
}
- (void)setupAddTagNavigationBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(completion)];
}

- (void)completion
{
    //取出所有按钮的标题文字存入数组
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
   // LSPLog(@"tags = %@",tags);
    //传递tags给block
    !self.tagsBlock ? : self.tagsBlock(tags);
    
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  初始化tag的标签
 */
- (void)setupTags
{
    if (self.tags.count) {
        for (NSString *tagTitle in self.tags) {
            self.textField.text = tagTitle;
            [self addButtonClick];
        }
      self.tags = nil;
    }
    
}
/**
 *  监听textfield内部文字的改变
 */
- (void)textDidChanged
{
    //更新文本框的frame
    [self updateTextFieldFrame];
    
    if (self.textField.hasText) {//有文字内容
        //显示“标签按钮”
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + LSPTagMargin;
        NSString *title = [NSString stringWithFormat:@"标签内容:%@",self.textField.text];
        [self.addButton setTitle:title forState:UIControlStateNormal];
        //或的输入的最后一个字符
        NSString *text = self.textField.text;
        NSUInteger len = text.length;
        NSString *lastLetter = [text substringFromIndex:len - 1];
        if ([lastLetter isEqualToString:@","] || [lastLetter isEqualToString:@"，"]) {
            self.textField.text = [text substringToIndex:len - 1];
            [self addButtonClick];
        }
        
    }else{
        //隐藏“标签按钮”
        self.addButton.hidden = YES;
    }
    
}
/**
 *  监听添加按钮的点击事件
 */
- (void)addButtonClick
{
    if (self.tagButtons.count == 5) {
        
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签"];
        return;
    }
    //添加一个“标签按钮”
    LSPTagButton *tagButton = [LSPTagButton buttonWithType:UIButtonTypeCustom];
   
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    
    //[tagButton sizeToFit];
    tagButton.height = self.textField.height;
    
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    //更新标签按钮的frame
    [self updateTagButtonFrame];
     [self updateTextFieldFrame];
    //清空文字
    self.textField.text = nil;
    self.addButton.hidden = YES;
}
/**
 *  点击标签按钮的触发事件
 *
 */
- (void)tagButtonClick:(LSPTagButton *)tagButton
{
    //删除标签按钮
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    //更新按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
         [self updateTagButtonFrame];
         [self updateTextFieldFrame];
    }];
   
}
/**
 *  专门用来更新标签按钮的frame
 */
- (void)updateTagButtonFrame
{
    for (int i = 0; i < self.tagButtons.count; i ++) {
        LSPTagButton *tagButton = self.tagButtons[i];
        
        if (0 == i) {//第一个标签按钮
            tagButton.x = 0;
            tagButton.y = 0;
        }else{
            
            //获取上一个按钮
            LSPTagButton *lastTagButton = self.tagButtons[i - 1];
            //计算左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + LSPTagMargin;
            //计算右边的宽度
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagButton.width) {//显示在当前行
                tagButton.y = lastTagButton.y;
                tagButton.x = leftWidth;
            }else{//显示在下一行
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + LSPTagMargin;
                
            }
            
        }
    }
    //更新文本输入框的frame
    //[self updateTextFieldFrame];
    
   // self.textField.x = 0;
    //self.textField.y = CGRectGetMaxY(lastButton.frame) +LSPTagMargin;
}
/**
 *  更新文本输入框的frame
 */
- (void)updateTextFieldFrame
{
    //取出最后一个按钮
    LSPTagButton *lastButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastButton.frame) + LSPTagMargin;
    if (self.contentView.width - leftWidth  >= [self textFieldWidth]) {
        
        self.textField.x = leftWidth;
        self.textField.y = lastButton.y;
        
    }else{
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastButton.frame) + LSPTagMargin;
    }
    //更新“添加标签”frame
    self.addButton.y = CGRectGetMaxY(self.textField.frame) + LSPTagMargin;
    

}
/**
 *  textField输入的文字宽度
 *
 */
- (CGFloat)textFieldWidth
{
    CGFloat textWidth = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, textWidth);
}
/**
 *  控制器view内部的子控件布局完成后会调用这个方法来
 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //contentView
    self.contentView.x = LSPTagMargin;
    self.contentView.y = 64 + LSPTagMargin;
    self.contentView.width = self.view.width - 2 * self.contentView.x;
    self.contentView.height = LSPScreenH;
    
    self.textField.width = self.contentView.width;
    self.addButton.width = self.contentView.width;
    
    //初始化tag标签
    [self setupTags];
}

#pragma mark--<UITextFieldDelegate>
/**
 *  监听键盘右下角按钮的点击（例如：换行，return,go,next）
 *
 */
- (BOOL)textFieldShouldReturn:(LSPTagTextField *)textField
{
    if(textField.hasText){
        [self addButtonClick];
    }
    return YES;
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
