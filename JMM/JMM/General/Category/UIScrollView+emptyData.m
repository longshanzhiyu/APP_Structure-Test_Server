//
//  UIScrollView+emptyData.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "UIScrollView+emptyData.h"

@interface UIScrollView()
@property (nonatomic,copy) EmptyDataClickedBlock buttonBlock;///button点击block
@property (nonatomic,assign) EmptyDataType emptyType;///空页面类型

@end

@implementation UIScrollView (emptyData)
- (void)setButtonBlock:(EmptyDataClickedBlock)buttonBlock
{
    objc_setAssociatedObject(self, @selector(buttonBlock), buttonBlock, OBJC_ASSOCIATION_RETAIN);
}
- (EmptyDataClickedBlock)buttonBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEmptyType:(EmptyDataType)emptyType
{
    objc_setAssociatedObject(self, @selector(emptyType), @(emptyType), OBJC_ASSOCIATION_RETAIN);
    
}
- (EmptyDataType)emptyType
{
    return [objc_getAssociatedObject(self, _cmd) intValue];
}

-(void)showEmptyWithType:(EmptyDataType)emptyDataType clickedBlock:(EmptyDataClickedBlock)clickedBlock
{
    self.emptyType = emptyDataType;
    self.buttonBlock = clickedBlock;
    if (!self.emptyDataSetDelegate) {
        self.emptyDataSetDelegate = self;
    }
    if (!self.emptyDataSetSource) {
        self.emptyDataSetSource = self;
    }
    [self reloadEmptyDataSet];
}

#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"您的网络不稳定，请刷新重试";
    if (self.emptyType == EmptyDataTypeNoData) {
        text = @"您还没有任何记录呦～";
    }
    UIColor *textColor = UIColorFromHex(0x999A99);
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    [attributes setObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    return attributedString;
    
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if(self.emptyType == EmptyDataTypeLoading){
        return nil;
    }
    UIImage *image = [UIImage imageNamed:@"common_nonetwork"];
    if (self.emptyType == EmptyDataTypeNoData) {
        image = [UIImage imageNamed:@"common_norecords"];
    }
    return image;
}
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView;
{
    if(self.emptyType != EmptyDataTypeLoading){
        return nil;
    }
    UIView *view = [[UIView alloc]init];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(scrollView.bounds.size.height);
    }];
    UIView *containerView = [UIView new];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.layer.cornerRadius = 4.f;
    containerView.layer.masksToBounds = YES;
    [view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(view);
        make.width.height.mas_equalTo(110);
    }];
    YYImage *image = [YYImage imageNamed:@"common_loading.gif"];
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"加载中";
    label.textAlignment = NSTextAlignmentCenter;
    
    [containerView addSubview:imageView];
    [containerView addSubview:label];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(75);
        make.top.centerX.mas_equalTo(containerView);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.top.mas_equalTo(imageView.mas_bottom);
    }];
    return view;
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    if (self.emptyType == EmptyDataTypeNoData) {
        return nil;
    }
    NSString *text = @"点击刷新重试";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16],
                                 NSForegroundColorAttributeName:UIColorFromHex(0x999A99)
                                 };
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button;
{
    if (self.buttonBlock) {
        self.buttonBlock();
    }
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return - kRealValue(60);
}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView
{
    
}
- (void)emptyDataSetWillDisappear:(UIScrollView *)scrollView
{
    
}
- (void)emptyDataSetDidDisappear:(UIScrollView *)scrollView
{
    
}
@end
