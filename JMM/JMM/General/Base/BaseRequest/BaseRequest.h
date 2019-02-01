//
//  BaseRequest.h
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "YTKBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN
/**
 请求头参数model
 */
@interface Header : NSObject
@property (nonatomic,copy) NSString * Authorization;//用户登录后分配的登录Token
@property (nonatomic,copy) NSString * ContentType;
@end


/**
 接口请求基类，所有请求必须继承此类
 这里采用的是YTKNetwork网络库，中大型APP专用，可满足所有网络需求
 学习地址：https://github.com/yuantiku/YTKNetwork
 */
@interface BaseRequest : YTKBaseRequest
@property(nonatomic,assign)BOOL isOpenAES;//是否开启加密 默认开启

//自定义属性值
@property(nonatomic,assign)BOOL isSuccess;//是否成功
@property (nonatomic,copy) NSString *code;//服务器返回的状态码
@property (nonatomic,copy) NSString *message;//服务器返回的信息
@property (nonatomic,copy) NSDictionary *result;//服务器返回的数据 已解密
@property (nonatomic, strong) id<NSObject> data;/// 自定的返回model

/***
 指定DATA返回的类型(data为非数组类型时必须实现)
 实现以下方法 并且覆盖父类data实现
 */
+ (Class)modelClassForDATA;



/**
 指定DATA包含的model类型(data为数组类型时必须实现)
 
 @return model类型
 */
+ (Class)itemClassForDATA;

/**
 发起网络请求 （已判断服务器状态码)
 
 @param success 成功回调
 @param failure 失败回调
 @param networkFail 网络错误回调
 */
- (void)startRequestWithSuccess:(YTKRequestCompletionBlock)success
                        failure:(YTKRequestCompletionBlock)failure
                    networkFail:(YTKRequestCompletionBlock)networkFail;

/**
 发起网络请求（已判断服务器状态码,网络错误的情况已统一弹框）
 
 @param success 成功回调
 @param failure 失败回调
 */
- (void)startRequestWithSuccess:(YTKRequestCompletionBlock)success
                        failure:(YTKRequestCompletionBlock)failure;

/**
 发起网络请求（已判断服务器状态码,网络错误，失败的情况已统一弹框）
 
 @param success 成功回调
 */
- (void)startRequestWithSuccess:(YTKRequestCompletionBlock)success;
@end

NS_ASSUME_NONNULL_END
