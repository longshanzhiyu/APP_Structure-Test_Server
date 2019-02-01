//
//  UIScrollView+emptyData.h
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EmptyDataType)
{
    EmptyDataTypeNoNetWork,//无网络
    EmptyDataTypeNoData,//无数据
    EmptyDataTypeLoading,//加载中
    
};
typedef void(^EmptyDataClickedBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (emptyData)<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

-(void)showEmptyWithType:(EmptyDataType)emptyDataType clickedBlock:(EmptyDataClickedBlock)clickedBlock;

@end

NS_ASSUME_NONNULL_END
