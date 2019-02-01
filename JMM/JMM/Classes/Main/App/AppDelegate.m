//
//  AppDelegate.m
//  JMM
//
//  Created by hqy on 2019/1/30.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [AppInitInstance setup];
    self.window.rootViewController = self.navigationController;
    //此处判断是否登录
    if ([UserManager share].user == nil) {
        //        [self.navigationController presentViewController:loginNav animated:NO completion:nil];
        self.window.rootViewController = self.loginVC;
    }
    
    [[UserManager share] addObserver:self forKeyPath:@"user" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    id newUser = [change objectForKey:@"new"];
    if ([newUser isKindOfClass:[NSNull class]]) {
        for (UIViewController *vc in self.tabBarController.childViewControllers) {
            if ([vc isKindOfClass:[UINavigationController class]]) {
                UINavigationController *nav = (UINavigationController *)vc;
                [nav popToRootViewControllerAnimated:NO];
            }
        }
        self.tabBarController.selectedIndex = 0;
        self.window.rootViewController = self.loginVC;
    }
    else {
        self.window.rootViewController = self.navigationController;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    //清除图标的圆点提示 （推送）
    if ([UIApplication sharedApplication].applicationIconBadgeNumber >0) {
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark getter
- (UIWindow *)window
{
    if (!_window)
    {
        _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor whiteColor];
        [_window makeKeyAndVisible];
    }
    return _window;
}
- (RTRootNavigationController *)navigationController
{
    if (!_navigationController) {
        _navigationController = [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:self.tabBarController];
    }
    return _navigationController;
}

-(BaseTabBarController *)tabBarController
{
    if (!_tabBarController) {
        _tabBarController = [[RootTabBarController alloc]init];
    }
    return _tabBarController;
}

- (RTRootNavigationController *)loginVC {
    LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    RTRootNavigationController *loginNav = [[RTRootNavigationController alloc] initWithRootViewController:login];
    return loginNav;
}
@end
