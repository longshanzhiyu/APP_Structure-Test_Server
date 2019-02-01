//
//  SettingGroup.h
//  SmartHospital
//
//  Created by njw on 2018/9/14.
//  Copyright © 2018年 com.smartcity.pingan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingGroup : NSObject
// 头部标题
@property (nonatomic, copy) NSString *headTitle;
// 尾部标题
@property (nonatomic, copy) NSString *footerTitle;
// 组中的选项
@property (nonatomic, strong) NSMutableArray *items;
@end
