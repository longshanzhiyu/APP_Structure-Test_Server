//
//  RTRootNavigationController+Jump.m
//  HDProjectiOS
//
//  Created by 彭星 on 2018/12/15.
//  Copyright © 2018 pingan.smartcity. All rights reserved.
//

#import "RTRootNavigationController+Jump.h"

@implementation RTRootNavigationController (Jump)
//push时隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.rt_viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popToVCClass:(Class)VCClass animated:(BOOL)animated
{
    NSArray *controllers =  self.rt_viewControllers;
    [controllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:VCClass]) {
            [self popToViewController:obj animated:animated complete:NULL];
            *stop = YES;
        }
    }];
}

- (void)pushToVC:(UIViewController *)pushVc fromClass:(Class)fromClass animated:(BOOL)animated;
{
    
    NSArray *ns = self.rt_viewControllers;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [ns enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:vc];
        if ([vc isKindOfClass:[fromClass class]]) {
            *stop = YES;
        }
    }];
    [array addObject:pushVc];
    [self setViewControllers:array animated:animated];
    
    
}

- (void)popToBeforeViewController:(NSInteger)integer animated:(BOOL)animated
{
    if (integer <= 0) {
        return;
    }
    
    NSInteger index = self.rt_viewControllers.count - integer - 1;
    if (index < 0) {
        return;
    }
    
    UIViewController *vc = self.rt_viewControllers[index];
    [self popToViewController:vc animated:animated complete:NULL];
}

@end
