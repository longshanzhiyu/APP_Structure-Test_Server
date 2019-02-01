//
//  BaseDataModel.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "BaseDataModel.h"

@implementation BaseDataModel
+ (instancetype)getModelByData:(id)data
{
    return [self modelWithJSON:data];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key { }
@end
