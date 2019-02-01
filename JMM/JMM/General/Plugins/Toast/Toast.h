//
//  Toast.h
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>


///Toast配置
@interface ToastConfig: NSObject


///全局配置
+ (ToastConfig *)globalConfig;
///重置全局配置
+(void)resetGlobalConfig;

///初始化自定义配置
+ (ToastConfig *)config;


///颜色   Default: 半透明黑色
@property(nonatomic,strong) UIColor *bezelViewColor;
///背景颜色  Default: 透明
@property(nonatomic,strong) UIColor *backgroundViewColor;
///圆角   Default: 5
@property(nonatomic,assign) CGFloat cornerRadius;
///内容颜色     Default: 白色
@property(nonatomic,strong) UIColor *contentColor;
///字体大小   Default: 16
@property(nonatomic,assign) CGFloat contentFontSize;
///持续时间:-1为常驻   Default: 2s
@property(nonatomic,assign) NSTimeInterval duration;

///成功icon  Default: "loaddingsuccess"
@property(nonatomic,strong) UIImage *successImage;
///失败icon  Default: "loaddingfailure"
@property(nonatomic,strong) UIImage *failureImage;

///自定义  Default: nil
@property(nonatomic,strong) UIView *customView;

///文字内容 Default: nil
@property(nonatomic,copy) NSString *text;

///progress  Default: 0
@property(nonatomic,assign) CGFloat progress;



@end



@interface UIView (Toast)



/**
 显示文字
 
 @ram text 文字内容
 @ram config 配置
 */
-(void)showText:(NSString*)text config:(ToastConfig*)config;
-(void)showText:(NSString*)text;



/**
 显示加载
 
 @ram text 文字内容
 @ram config 配置
 */
-(void)showLoading:(NSString*)text config:(ToastConfig*)config;
-(void)showLoading:(NSString*)text;



/**
 显示上传
 
 @ram text 文字内容
 @ram config 配置
 */
-(void)showUpload:(NSString*)text config:(ToastConfig*)config;
-(void)showUpload:(NSString*)text;



/**
 显示成功
 
 @ram text 文字内容
 @ram config 配置
 */
-(void)showSuccess:(NSString*)text config:(ToastConfig*)config;
-(void)showSuccess:(NSString*)text;



/**
 显示失败
 
 @ram text 文字内容
 @ram config 配置
 */
-(void)showFailure:(NSString*)text config:(ToastConfig*)config;
-(void)showFailure:(NSString*)text;



/**
 消失
 */
-(void)dismiss;




@end
