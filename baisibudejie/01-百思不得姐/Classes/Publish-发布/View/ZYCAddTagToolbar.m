//
//  ZYCAddTagToolbar.m
//  01-百思不得姐
//
//  Created by wpzyc on 2017/7/24.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCAddTagToolbar.h"
#import "ZYCAddTagViewController.h"
@interface ZYCAddTagToolbar()
/** 顶部控件 */
@property (weak, nonatomic) IBOutlet UIView *topView;
/** 添加按钮 */
@property (weak, nonatomic) IBOutlet UIButton *addButton;
/** 存放所有的标签label */
@property(nonatomic,strong)NSMutableArray *tagLabels;
@end
@implementation ZYCAddTagToolbar

- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    //添加一个加号
    UIButton *addButton = [[UIButton alloc]init];
    
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //依据图片大小确定按钮大小
//    addButton.size = [UIImage imageNamed:@"tag_add_icon"].size;
//    addButton.size = [addButton imageForState:UIControlStateNormal].size;
    addButton.size = addButton.currentImage.size;
    addButton.x = ZYCTagMargin;
    [self.topView addSubview:addButton];
    
    self.addButton = addButton;
}

- (void)addButtonClick
{
    ZYCAddTagViewController *addtagVc = [[ZYCAddTagViewController alloc]init];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
  

    __weak typeof(self) weakSelf = self;
    addtagVc.tagsBlock = ^(NSArray *tags) {
        [weakSelf creatTagLabels:tags];
        
    };
    addtagVc.tags = [self.tagLabels valueForKeyPath:@"text"];
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    [nav pushViewController:addtagVc animated:YES];
    //a modal 出b
//    a.presentedViewController ->b
//    b.presentingViewController - >a
    
}

//创建标签
- (void)creatTagLabels:(NSArray *)tags
{
    //清空tagLabels
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    for (int i = 0; i<tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc]init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.text = tags[i];
        tagLabel.textColor = [UIColor whiteColor];
        tagLabel.backgroundColor = ZYCTagBG;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.font = ZYCTagFont;
        //先设置文字和字体后，再进行计算
        [tagLabel sizeToFit];
        tagLabel.width += 2*ZYCTagMargin;
        tagLabel.height = ZYCTagH;
        [self.topView addSubview:tagLabel];
        
        //设置位置
        if (i==0) {//最前面的标签
            tagLabel.x = 0;
            tagLabel.y = 0;
        }else{//其他标签
            UILabel *lastTagLabel = self.tagLabels[i-1];
            //计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame)+ZYCTagMargin;
            //计算当前行右边剩余的宽度
            CGFloat rightWidth = self.topView.width-CGRectGetMaxX(lastTagLabel.frame) - ZYCTagMargin;
            if (rightWidth >= tagLabel.width) {//按钮显示在当前行
                tagLabel.x = leftWidth;
                tagLabel.y = lastTagLabel.y;
            }else{//按钮显示在下一行
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame)+ZYCTagMargin;
            }
        }
    }
    //最后一个标签按钮
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    //计算当前行左边的宽度
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame)+ZYCTagMargin;
    if (self.topView.width -leftWidth >= self.addButton.width) {
        self.addButton.x = leftWidth;
        self.addButton.y = lastTagLabel.y;
    }else{
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame)+ ZYCTagMargin;
    }


    
    
}


@end
