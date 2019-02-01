//
//  BaseAutoRefreshTable.h
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseAutoRefreshTable : UITableView
//拉取新数据
- (void)beginLoadNewData;
//拉取更多数据
- (void)beginLoadMoreData;
//停止拉取新数据
- (void)stopLoadNewData;
//停止拉取更多数据
- (void)stopLoadMoreData;
//停止刷新，哪个正在刷新，停止哪个
- (void)stopLoad;
//隐藏头
- (void)hiddenHeader:(BOOL)isHidden;
//隐藏尾
- (void)hiddenFooter:(BOOL)isHidden;
//显示无更多数据
- (void)showNoticeNoMoreData;
//重置没有更多数据
- (void)resetNoMoreData;

- (BOOL)isHeaderRefresh;
- (BOOL)isFooterRefresh;
//滚动的时候是否停止编辑
- (BOOL)shouldEndEditingWhenScroll;
@end

NS_ASSUME_NONNULL_END
