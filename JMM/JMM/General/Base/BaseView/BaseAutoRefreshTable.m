//
//  BaseAutoRefreshTable.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "BaseAutoRefreshTable.h"

@implementation BaseAutoRefreshTable
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame style:style]) {
        
        if ([self showHeaderRefresh]){
            
            [self initHeader];
        }
        if ([self showFooterRefresh]){
            
            [self initFooter];
            [self hiddenFooter:YES];
        }
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]){
        
        if ([self showHeaderRefresh]){
            
            [self initHeader];
        }
        if ([self showFooterRefresh]){
            
            [self initFooter];
            [self hiddenFooter:YES];
        }
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if ([self showHeaderRefresh]){
        
        [self initHeader];
    }
    if ([self showFooterRefresh]){
        
        [self initFooter];
        [self hiddenFooter:YES];
    }
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)initHeader{
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (![weakSelf.mj_footer isRefreshing]) {
            [weakSelf.mj_footer resetNoMoreData];
            [weakSelf loadNewData];
        } else {
            [weakSelf.mj_header endRefreshing];
        }
    }];
    
    //设置文字
    [header setTitle:@"撒撒撒...手，立即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"努力刷新ing" forState:MJRefreshStateRefreshing];
    
    //设置字体
    //    header.stateLabel.textColor = [UIColor hexChangeFloat:@"999999"];
    //    header.lastUpdatedTimeLabel.textColor = [UIColor hexChangeFloat:@"999999"];
    //    header.stateLabel.font = [UIFont systemFontOfSize:12.f];
    //    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12.f];
    
    self.mj_header = header;
}

- (void)initFooter{
    
    __weak __typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (![self.mj_header isRefreshing]) {
            [weakSelf loadMoreData];
        } else {
            [weakSelf.mj_footer endRefreshing];
        }
    }];
    
    // 设置文字
    //    [footer setTitle:@"上拉查看更多内容吧" forState:MJRefreshStateIdle];
    //    [footer setTitle:@"努力加载ing" forState:MJRefreshStateRefreshing];
    //    [footer setTitle:@"没有更多啦" forState:MJRefreshStateNoMoreData];
    //设置字体
    //    footer.stateLabel.textColor = [UIColor hexChangeFloat:@"999999"];
    //    footer.stateLabel.font = [UIFont systemFontOfSize:12.f];
    
    self.mj_footer = footer;
}
//拉取新数据
- (void)beginLoadNewData{
    
    [self.mj_header beginRefreshing];
}

//拉取更多数据
- (void)beginLoadMoreData{
    
    [self.mj_footer beginRefreshing];
}

//停止拉取新数据
- (void)stopLoadNewData{
    
    [self.mj_header endRefreshing];
}

//停止拉取更多数据
- (void)stopLoadMoreData{
    
    if ([self.mj_footer isRefreshing]) {
        
        [self.mj_footer endRefreshing];
    }
}

//停止刷新，哪个正在刷新，停止哪个
- (void)stopLoad {
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}

//隐藏头
- (void)hiddenHeader:(BOOL)isHidden{
    
    self.mj_header.hidden = isHidden;
}

//隐藏尾
- (void)hiddenFooter:(BOOL)isHidden{
    self.mj_footer.hidden = isHidden;
}

//显示无更多数据
- (void)showNoticeNoMoreData{
    
    [self.mj_footer endRefreshingWithNoMoreData];
}

//重置没有更多数据
- (void)resetNoMoreData {
    
    [self.mj_footer resetNoMoreData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    BOOL endEditWhenScroll = [self shouldEndEditingWhenScroll];
    if (endEditWhenScroll) {
        [self.viewController.view endEditing:YES];
        [self endEditing:YES];
    }
}
#pragma mark - 继承者
- (BOOL)shouldEndEditingWhenScroll
{
    return YES;
}

- (BOOL)showHeaderRefresh{
    
    return NO;
}

- (BOOL)showFooterRefresh{
    
    return NO;
}

- (void)loadNewData{
    
}

- (void)loadMoreData{
    
}
- (BOOL)isHeaderRefresh {
    
    return self.mj_header.isRefreshing;
}
- (BOOL)isFooterRefresh {
    
    return self.mj_footer.isRefreshing;
}

@end
