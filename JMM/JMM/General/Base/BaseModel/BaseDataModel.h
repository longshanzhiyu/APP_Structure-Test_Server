//
//  BaseDataModel.h
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseDataModel : NSObject
+ (instancetype)getModelByData:(id)data;
@end

NS_ASSUME_NONNULL_END
