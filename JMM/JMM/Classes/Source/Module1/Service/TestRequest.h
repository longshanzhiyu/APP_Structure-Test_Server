//
//  TestRequest.h
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "BaseRequest.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestRequest : BaseRequest
//此处添加属性 （即请求的参数 给服务器端传的body）
//@property (nonatomic, copy) type param1
//@property (nonatomic, strong) type param2



//返回数据
@property (strong, nonatomic) User *user;
@end

NS_ASSUME_NONNULL_END
