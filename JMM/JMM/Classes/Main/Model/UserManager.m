//
//  UserManager.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager
+ (instancetype)share{
    static dispatch_once_t onceToken;
    static UserManager *userManager;
    dispatch_once(&onceToken, ^{
        userManager = [UserManager new];
    });
    return  userManager;
}
@end
