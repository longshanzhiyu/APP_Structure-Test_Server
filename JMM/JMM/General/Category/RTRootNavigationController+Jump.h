//
//  RTRootNavigationController+Jump.h
//  HDProjectiOS
//
//  Created by 彭星 on 2018/12/15.
//  Copyright © 2018 pingan.smartcity. All rights reserved.
//

#import "RTRootNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RTRootNavigationController (Jump)
/**
 用于回退到指定控制器类
 
 @param VCClass 目的类
 @param animated 是否开启动画
 */
- (void)popToVCClass:(Class)VCClass animated:(BOOL)animated;


/**
 去掉fromVc至pushVc 之间的视图
 
 @param pushVc 目标视图
 @param fromClass 源视图
 @param animated description
 */
- (void)pushToVC:(UIViewController *)pushVc fromClass:(Class)fromClass animated:(BOOL)animated;


/**
 *  去掉fromVc至pushVc 之间的视图
 *
 *  @param integer 指定向前删除几个视图
 *  @param animated animated description
 */
- (void)popToBeforeViewController:(NSInteger)integer animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
