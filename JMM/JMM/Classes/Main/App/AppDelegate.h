//
//  AppDelegate.h
//  JMM
//
//  Created by hqy on 2019/1/30.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong) RootTabBarController *tabBarController;

@property(nonatomic,strong) RTRootNavigationController *navigationController;

@end

