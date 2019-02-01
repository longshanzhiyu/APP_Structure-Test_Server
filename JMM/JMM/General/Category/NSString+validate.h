//
//  NSString+validate.h
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (validate)
/**
 字符串校验类
 */
- (BOOL)isIDCardWithString;/**<是否为合法身份证*/
- (BOOL)isMatchAge;/**<是否是合法年龄*/
- (BOOL)isPhoneNumberString;/**<是否为合法电话号码*/
- (BOOL)isMoneyNumberString;/**<是否为正确金额*/
- (BOOL)isValideMoneyString;/**<是否为正确的金额*/
- (BOOL)isCardNumberString;/**<是否是正确银行卡号*/
- (BOOL)isAlphabetAndNumber;/**<是否是纯数字或字母*/
- (BOOL)isPureAlphabet;/**<是否是纯字母*/
- (BOOL)isPureNumber;/**<是否是纯数字*/
-(NSString *)getPhoneCompany;/**<根据电话号码得到运营公司*/
- (BOOL)isValidateEmail;/**<判断一个字符创是否为合法邮箱地址*/
@end

NS_ASSUME_NONNULL_END
