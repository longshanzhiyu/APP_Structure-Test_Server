//
//  ArrowSetting.h
//  HDProjectiOS
//
//  Created by 牛建委 on 12/12/2018.
//  Copyright © 2018 pingan.smartcity. All rights reserved.
//

#import "BaseSettingModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArrowSetting : BaseSettingModel
/**
 *  点击这行cell需要跳转的控制器
 */
@property (nonatomic, assign) Class destVcClass;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;

+ (instancetype)itemTitle:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass;
@end

NS_ASSUME_NONNULL_END
