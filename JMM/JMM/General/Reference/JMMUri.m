//
//  JMMUri.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "JMMUri.h"

NSString *const kReleaseServerUrl = @"http://localhost:8080/";/**<生产测试地址*/

NSString *const kDebugServerUrl = @"http://localhost:8080/";/**<外网测试地址*/


#if DEBUG
BOOL kPCReleaseFlag =NO;/**<配置项目是否为发布版*/
#else
BOOL kPCReleaseFlag =YES;/**<配置项目是否为发布版*/
#endif
