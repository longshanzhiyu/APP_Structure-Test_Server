//
//  User.h
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
@property (nonatomic, assign) BOOL isFirstOpen;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *gender;
@end

NS_ASSUME_NONNULL_END
