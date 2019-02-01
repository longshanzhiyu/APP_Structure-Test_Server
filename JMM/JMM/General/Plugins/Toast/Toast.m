//
//  Toast.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "Toast.h"


typedef NS_ENUM(NSUInteger, ToastType)
{
    eToastTypeText,
    eToastTypeLoadding,
    eToastTypeUpload,
    eToastTypeCustom
};



@implementation ToastConfig
{
    void(^_configDidChanged)(NSString*,id);
}

static ToastConfig *config = nil;
static dispatch_once_t onceToken;

+ (ToastConfig *)globalConfig
{
    dispatch_once(&onceToken, ^{
        
        config = [ToastConfig new];
        
        config.bezelViewColor = [UIColor colorWithWhite:0 alpha:0.8f];
        config.backgroundViewColor = [UIColor clearColor];
        config.cornerRadius = 5.0f;
        config.contentColor = [UIColor whiteColor];
        config.contentFontSize = 16.0f;
        config.duration = 2.0f;
        
        config.successImage = [UIImage imageNamed:@"loaddingsuccess"];
        config.failureImage = [UIImage imageNamed:@"loaddingfailure"];
        
    });
    
    return config;
}

+(void)resetGlobalConfig
{
    config = nil;
    onceToken = 0;
}

+(instancetype)config
{
    ToastConfig *config = [ToastConfig new];
    ToastConfig *globalConfig = [ToastConfig globalConfig];
    
    config.bezelViewColor = globalConfig.bezelViewColor;
    config.backgroundViewColor = globalConfig.backgroundViewColor;
    config.cornerRadius = globalConfig.cornerRadius;
    config.contentColor = globalConfig.contentColor;
    config.contentFontSize = globalConfig.contentFontSize;
    config.duration = globalConfig.duration;
    config.successImage = globalConfig.successImage;
    config.failureImage = globalConfig.failureImage;
    config.customView = globalConfig.customView;
    
    return config;
}

-(void)setText:(NSString *)text
{
    _text = text;
    _configDidChanged ? _configDidChanged(@"detailsLabel.text",text):nil;
}

-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    _configDidChanged ? _configDidChanged(@"progress",@(progress)):nil;
}

-(void)configDidChanged:(void(^)(NSString*,id))handler
{
    _configDidChanged = handler;
}

@end






@implementation UIView (Progress)

-(void)showText:(NSString*)text
{
    [self showText:text config:nil];
}

-(void)showText:(NSString*)text config:(ToastConfig*)config
{
    ToastType toastType = eToastTypeText;
    
    if (config && config.customView)
    {
        toastType = eToastTypeCustom;
    }
    [self show:text type:toastType config:config];
}


-(void)showLoading:(NSString*)text
{
    [self showLoading:text config:nil];
}

-(void)showLoading:(NSString*)text config:(ToastConfig*)config
{
    if (!config)
    {
        config = [ToastConfig config];
        config.duration = -1.0f;
    }
    
    ToastType toastType = config.customView ? eToastTypeCustom : eToastTypeLoadding;
    
    [self show:text type:toastType config:config];
}


-(void)showUpload:(NSString*)text
{
    [self showUpload:text config:nil];
}

-(void)showUpload:(NSString*)text config:(ToastConfig*)config
{
    if (!config)
    {
        config = [ToastConfig config];
        config.duration = -1.0f;
    }
    
    ToastType toastType = config.customView ? eToastTypeCustom : eToastTypeUpload;
    
    [self show:text type:toastType config:config];
}



-(void)showSuccess:(NSString*)text
{
    [self showSuccess:text config:nil];
}

-(void)showSuccess:(NSString*)text config:(ToastConfig*)config
{
    if (!config)
    {
        config = [ToastConfig config];
    }
    
    config.customView =  config.customView ?: [[UIImageView alloc] initWithImage:config.successImage];
    
    [self show:text type:eToastTypeCustom config:config];
}


-(void)showFailure:(NSString*)text
{
    [self showFailure:text config:nil];
}

-(void)showFailure:(NSString*)text config:(ToastConfig*)config
{
    if (!config)
    {
        config = [ToastConfig config];
    }
    
    config.customView =  config.customView ?: [[UIImageView alloc] initWithImage:config.failureImage];
    
    [self show:text type:eToastTypeCustom config:config];
}



-(void)show:(NSString*)text type:(ToastType)type config:(ToastConfig*)config
{
    config = config ?: [ToastConfig globalConfig];
    
    MBProgressHUD *hud = [self hud:config];
    
    [config configDidChanged:^(NSString *key, id value) {
        if([key containsString:@"."])
        {
            [hud setValue:value forKeyPath:key];
        }
        else
        {
            [hud setValue:value forKey:key];
        }
    }];
    
    config.text = text;
    
    switch (type)
    {
        case eToastTypeText:
        {
            hud.mode = MBProgressHUDModeText;
        }
            break;
            
        case eToastTypeLoadding:
        {
            hud.mode = MBProgressHUDModeIndeterminate;
        }
            break;
            
        case eToastTypeUpload:
        {
            hud.mode = MBProgressHUDModeAnnularDeterminate;
        }
            break;
        case eToastTypeCustom:
        {
            hud.mode = MBProgressHUDModeCustomView;
            hud.customView = config.customView;
        }
            break;
            
        default:
            break;
    }
}





-(MBProgressHUD*)hud:(ToastConfig*)config
{
    
    [self dismiss];
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = config.bezelViewColor;
    hud.backgroundView.color = config.backgroundViewColor;
    hud.bezelView.layer.cornerRadius = config.cornerRadius;
    hud.contentColor = config.contentColor;
    hud.detailsLabel.font = [UIFont systemFontOfSize:config.contentFontSize];
    config.duration > 0 ? [hud hideAnimated:YES afterDelay:config.duration] : nil;
    
    return hud;
    
}




-(void)dismiss
{
    [MBProgressHUD hideHUDForView:self animated:YES];
}






@end
