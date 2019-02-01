//
//  UIColor+produce.h
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromHex(HexValue) ([UIColor colorWithHex:HexValue])/**<转换16进制颜色*/

#define UI_ColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a] /**<RGB颜色设置*/

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (produce)

/**
 16进制获取颜色
 
 @param hex 16进制颜色值
 @return 颜色
 */
+ (UIColor *) colorWithHex:(unsigned int)hex;


/**
 16进制获取颜色，并且设置颜色透明度
 
 @param hex 16进制颜色值
 @param alpha 颜色透明度
 @return 颜色
 */
+ (UIColor *) colorWithHex:(unsigned int)hex
                     alpha:(CGFloat)alpha;


/**
 随机获取颜色
 
 @return 颜色
 */
+ (UIColor *) randomColor;
@end

NS_ASSUME_NONNULL_END
