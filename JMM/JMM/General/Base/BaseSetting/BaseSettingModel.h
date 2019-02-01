//
//  BaseSettingModel.h
//  SmartHospital
//
//  Created by njw on 2018/9/12.
//  Copyright © 2018年 com.smartcity.pingan. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^SettingItemOption)(id);
@interface BaseSettingModel : NSObject

@property (nonatomic, copy) SettingItemOption option;
/**
 *  图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  子标题
 */
@property (nonatomic, copy) NSString *subtitle;

/**
 *  子标题
 */
@property (nonatomic, copy) NSString *detailTitle;

/**
 *  cell高度
 */
@property (nonatomic, assign) CGFloat cellHeight;


+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title withSubtitle:(NSString *)subtitle;
+ (instancetype)itemWithTitle:(NSString *)title withSubtitle:(NSString *)subtitle withDetailTitle:(NSString *)detailTitle;
+ (instancetype)itemWithIcon:(NSString *)icon WithTitle:(NSString *)title withSubtitle:(NSString *)subtitle;
@end
