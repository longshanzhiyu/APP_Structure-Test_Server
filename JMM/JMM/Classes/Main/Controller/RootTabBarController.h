//
//  RootTabBarController.h
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "BaseTabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RootTabBarController : BaseTabBarController
/**
 设置小红点
 
 @param index tabbar下标
 @param isShow 是显示还是隐藏
 */
-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow;
@end

NS_ASSUME_NONNULL_END
