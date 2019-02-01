//
//  JMMServerConfig.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "JMMServerConfig.h"
#import "JMMUri.h"

@implementation JMMServerConfig
static NSString *kDebugRequestServerUrl;/**测试环境地址*/
static NSString *kDebugRequestServerUrlNew;/**测试环境地址*/
static NSString *kSessionFlag;

+ (NSString *)getServerUrl
{
    NSString *serverUrl;
    
    if (kDebugRequestServerUrl.length > 0) {
        serverUrl = kDebugRequestServerUrl;
    } else if (kPCReleaseFlag) {
        serverUrl = kReleaseServerUrl;
    } else {
        serverUrl = kDebugServerUrl;
    }
    
    return [serverUrl stringByAppendingString:@""];
}

+ (void)setServerUrl:(NSString *)url
{
    kDebugRequestServerUrl = url;
}
@end
