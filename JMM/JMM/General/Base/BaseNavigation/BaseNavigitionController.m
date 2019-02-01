//
//  BaseNavigitionController.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "BaseNavigitionController.h"

@interface BaseNavigitionController ()

@end

@implementation BaseNavigitionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rt_disableInteractivePop = NO;
}
//push时隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popToVCClass:(Class)VCClass animated:(BOOL)animated
{
    NSArray *controllers =  self.viewControllers;
    [controllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:VCClass]) {
            [self popToViewController:obj animated:animated complete:NULL];
            *stop = YES;
        }
    }];
}

- (void)pushToVC:(UIViewController *)pushVc fromClass:(Class)fromClass animated:(BOOL)animated;
{
    
    NSArray *ns = self.viewControllers;
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
    
    NSInteger index = self.viewControllers.count - integer - 1;
    if (index < 0) {
        return;
    }
    
    UIViewController *vc = self.viewControllers[index];
    [self popToViewController:vc animated:animated complete:NULL];
}

@end
