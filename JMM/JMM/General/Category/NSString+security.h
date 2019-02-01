//
//  NSString+security.h
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (security)
/**
 利用系统自带base64编码
 
 @return 编码后的字符串
 */
- (NSString *)stringWithBase64;

/**
 利用系统自带base64编码
 
 @return 解码后的字符串
 */
- (NSString *)decodeBase64StringToString;

/**
 通过字体属性来计算文字高度
 
 @param attrs 字体属性设置
 @param size 需要加载字体的控件大小
 @return 字体所占区域大小
 */
- (CGSize)sizeWithAttributes:(NSDictionary *)attrs constrainedToSize:(CGSize)size;


/**
 去除空格
 
 @return 已去除空格的字符串
 */
- (NSString *)trim;


/**
 判断字体是否为空
 
 @return 布尔值
 */
- (BOOL)isNilOrEmpty;


/**
 将金额转为千分制显示
 
 @return 结果
 */
- (NSString *)permilString;
@end

NS_ASSUME_NONNULL_END
