//
//  BaseSettingModel.m
//  SmartHospital
//
//  Created by njw on 2018/9/12.
//  Copyright © 2018年 com.smartcity.pingan. All rights reserved.
//

#import "BaseSettingModel.h"

@implementation BaseSettingModel

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    return [self itemWithIcon:icon WithTitle:title withSubtitle:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title withSubtitle:(NSString *)subtitle{
    return [self itemWithIcon:nil WithTitle:title withSubtitle:subtitle];
}

+ (instancetype)itemWithTitle:(NSString *)title withSubtitle:(NSString *)subtitle withDetailTitle:(NSString *)detailTitle {
    BaseSettingModel *item = [[self alloc] init];
    item.title = title;
    item.subtitle = subtitle;
    item.detailTitle = detailTitle;
    return item;
}

+ (instancetype)itemWithIcon:(NSString *)icon WithTitle:(NSString *)title withSubtitle:(NSString *)subtitle{
    BaseSettingModel *item = [[self alloc] init];
    item.icon = icon;
    item.subtitle = subtitle;
    item.title = title;
    return item;
}
@end
