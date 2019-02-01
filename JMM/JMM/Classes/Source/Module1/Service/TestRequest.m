//
//  TestRequest.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "TestRequest.h"

@implementation TestRequest
- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/login"];
}

-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

+ (Class)modelClassForDATA
{
    return User.class;
}
@end
