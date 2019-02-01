//
//  ArrowSetting.m
//  HDProjectiOS
//
//  Created by 牛建委 on 12/12/2018.
//  Copyright © 2018 pingan.smartcity. All rights reserved.
//

#import "ArrowSetting.h"

@implementation ArrowSetting
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    ArrowSetting *item = [self itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    return item;
}

+ (instancetype)itemTitle:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass {
    ArrowSetting *item = [self itemWithTitle:title withSubtitle:subTitle];
    item.destVcClass = destVcClass;
    return item;
}
@end
