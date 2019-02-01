//
//  AppInitInstance.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "AppInitInstance.h"

@implementation AppInitInstance
+ (void)setup
{
    [self initAlertView];
    [self initNetWorkConfig];
    [self initCrashReport];
    [self initLocation];
    [self initKeyboard];
    [self initShare];
    [self initUser];
}
#pragma mark -
#pragma mark 初始化弹框
+ (void)initAlertView
{
    AlertViewConfig *config = [AlertViewConfig globalConfig];
    config.titleFont = [UIFont systemFontOfSize:18];
    config.detailFont = [UIFont systemFontOfSize:15];
    config.itemNormalFont = [UIFont systemFontOfSize:18];
    config.itemHighlightFont = [UIFont systemFontOfSize:18];
    config.itemDisabledFont = [UIFont systemFontOfSize:18];
    config.titleColor = [UIColor blackColor];
    config.detailColor = UIColorFromHex(0x888888);
    config.itemNormalColor        = [UIColor whiteColor];
    config.itemHighlightColor     = [UIColor lightGrayColor];
    config.itemDisabledColor      = UIColorFromHex(0xABABAB);
    
}
#pragma mark -
#pragma mark 初始化bugly
+ (void)initCrashReport
{
#if DEBUG
#else
    //    BuglyConfig *config = [[BuglyConfig alloc] init];
    //    config.deviceIdentifier = [PAHDevice getDeviceIdentifier];
    //    [Bugly startWithAppId:BuglyKey config:config];
#endif
}

#pragma mark -
#pragma mark 初始化定位
+ (void)initLocation
{
    
}

#pragma mark -
#pragma mark 初始化网络配置

+(void)initNetWorkConfig{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.debugLogEnabled = YES;
    config.baseUrl = [JMMServerConfig getServerUrl];
    //设置可接受的数据类型
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"text/css", nil];
    NSString *keypath = @"jsonResponseSerializer.acceptableContentTypes";
    @try {
        [agent setValue:acceptableContentTypes forKeyPath:keypath];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    } @finally {
        
    }
}

#pragma mark -
#pragma mark 键盘
+ (void)initKeyboard
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = NO;
    manager.keyboardDistanceFromTextField = 10;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    manager.enableAutoToolbar = YES;
}

#pragma mark -
#pragma mark 初始化分享
+ (void)initShare
{
    
}

#pragma mark -
#pragma mark 用户数据初始化
+ (void)initUser
{
    // 处理用户数据
    // 使用UserManager类
    [UserManager share];
}
@end
