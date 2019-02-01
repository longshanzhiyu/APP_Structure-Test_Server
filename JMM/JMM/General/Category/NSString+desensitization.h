//
//  NSString+desensitization.h
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (desensitization)
/**
 *  脱敏姓名的姓第一位
 *
 *  @return 返回脱敏后的数据
 */
-(NSString *)firstNameDesensitize;
/**
 *  脱敏姓名
 *
 *  @return 返回脱敏后的数据
 */
- (NSString *)nameDesensitize;

/**
 *  脱敏身份证号
 *
 *  @return 返回脱敏后的数据
 */
- (NSString *)idNumDesensitize;

/**
 *  脱敏手机号
 *
 *  @return 返回脱敏后的数据
 */
- (NSString *)mobileNumDesensitize;
@end

NS_ASSUME_NONNULL_END
