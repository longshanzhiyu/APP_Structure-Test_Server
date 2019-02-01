//
//  JMMMacro.h
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#ifndef JMMMacro_h
#define JMMMacro_h

//获取屏幕宽高
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kMainWindow  ([UIApplication sharedApplication].keyWindow)

//获取导航栏、状态栏高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight     44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kBootomHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

//机型
#define kiPhone5        (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define kiPhone6        (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define kiPhone6Plus    (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)
#define kiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//屏幕比例
#define kWIDTH_6PLUS_SCALE        [UIScreen mainScreen].bounds.size.width/414.0f
#define kHEIGHT_6PLUS_SCALE       [UIScreen mainScreen].bounds.size.height/736.0f
#define kWIDTH_IPHONE6_SCALE      [UIScreen mainScreen].bounds.size.width/375.0f
#define kHEIGHT_IPHONE6_SCALE     [UIScreen mainScreen].bounds.size.height/667.0f
#define kWIDTH_IPHONE5_SCALE      [UIScreen mainScreen].bounds.size.width/320.0f
#define kHEIGHT_IPHONE5_SCALE     [UIScreen mainScreen].bounds.size.height/568.0f

//根据ip6的屏幕来拉伸
#define kRealValue(with) ((with)*(kScreenWidth/375.0f))

//强弱引用
#define WEAKSELF __weak typeof(self) weakSelf = self;
#define STRONGSELF __strong typeof(weakSelf) strongSelf = weakSelf;

//View 圆角和加边框
#define kViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define kViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//当前语言
#define kCurrentLanguage (［NSLocale preferredLanguages] objectAtIndex:0])

//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

//数据验证
#define StrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define SafeStr(f) (StrValid(f) ? f:@"")
#define HasString(str,key) ([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f) StrValid(f)
#define ValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define ValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define ValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

//打印当前方法名
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

#endif /* JMMMacro_h */
