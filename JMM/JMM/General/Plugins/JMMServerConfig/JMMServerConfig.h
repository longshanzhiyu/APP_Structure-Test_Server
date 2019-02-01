//
//  JMMServerConfig.h
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 配置后台服务器的IP地址
 */

@interface JMMServerConfig : NSObject
+ (NSString *)getServerUrl;
+ (void)setServerUrl:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
