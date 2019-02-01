//
//  BaseRequest.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "BaseRequest.h"
/**<请求头参数model*/
@implementation  Header
-(instancetype)init{
    self = [super init];
    if (self) {
        //        self.version = [UIApplication sharedApplication].appVersion;
        //        self.channel = @"App Store";
        //        self.mobile_model = [UIDevice currentDevice].machineModelName;
        //        self.mobile_brand = [UIDevice currentDevice].machineModel;
//        self.ContentType = @"application/json";
//        self.Authorization = [PAHUserManager share].token;//暂时写死，登录时返回
    }
    return self;
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ContentType" : @"Content-Type"};
}
@end


/**<接口请求基类*/
@implementation BaseRequest
-(instancetype)init{
    self = [super init];
    if (self) {
        self.isOpenAES = NO;
    }
    return self;
}

#pragma mark -
#pragma mark 自定义数据
- (NSString *)message {
    if (self.error) {
        return self.error.localizedDescription;
    }
    NSString *message = [NSString stringWithFormat:@"%@",self.result[@"msg"]];
    return message;
}
- (NSString *)code {
    NSString *code = [NSString stringWithFormat:@"%@",self.result[@"code"]];
    return code;
}
- (BOOL)isSuccess {
    
    BOOL isSuccess = NO;
    if ([self.code isEqualToString:@"200"]) {//根据服务器状态码判断
        isSuccess = YES;
    }
    return  isSuccess;
}
// 如果实现了该方法，则处理过程中会忽略该列表内的所有属性
+ (NSArray *)modelPropertyBlacklist
{
    return @[@"isOpenAES", @"isSuccess", @"message", @"result", @"data",@"dataFromCache",@"ignoreCache",@"requestPriority",@"tag", @"code"];
}

#pragma mark -
#pragma mark 定义返回数据格式，若是加密要用HTTP接受
-(YTKResponseSerializerType)responseSerializerType {
    if (self.isOpenAES) {
        return YTKResponseSerializerTypeHTTP;
    }
    return YTKResponseSerializerTypeJSON;
}

#pragma mark -
#pragma mark 默认请求方式 POST
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

#pragma mark -
#pragma mark 默认请求体是自身转json
-(id)requestArgument
{
    return [self modelToJSONObject];
}

#pragma mark -
#pragma mark 默认请求转成json
- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}

#pragma mark -
#pragma mark 请求失败过滤器
-(void)requestFailedFilter
{
    
}

#pragma mark -
#pragma mark 请求成功过滤器
-(void)requestCompleteFilter
{
    //解密
    if (self.isOpenAES) {
        //        self.result = aesDecryptWithData(self.responseData);
    }else{
        self.result = self.responseJSONObject;
    }
    
    //字典转模型
    id<NSObject> data = self.result[@"data"];
    if ([data isKindOfClass:[NSArray class]]) {
        Class itemClass = [self.class itemClassForDATA];
        self.data = [NSArray modelArrayWithClass:itemClass json:data];
    }else if([data isKindOfClass:[NSDictionary class]]){
        
        Class class = [self.class modelClassForDATA];
        if (class) {
            self.data = [class modelWithJSON:data];
        }
        else {
            self.data = data;
        }
        
    }else{
        self.data = data;
    }
}
#pragma mark -
#pragma mark 设置请求超时时间
- (NSTimeInterval)requestTimeoutInterval
{
    return 30;
}

#pragma mark -
#pragma mark 非加密时也要传输的头部内容 也可能不需要，暂时保留
-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    //加密header部分
    NSDictionary *headDic = [[Header new] modelToJSONObject];
    return headDic;
    
}


#pragma mark -
#pragma mark 如果是加密方式传输，自定义request
-(NSURLRequest *)buildCustomUrlRequest
{
    return nil;
}
#pragma mark -
#pragma mark 子类必须实现的方法，返回当前的类
+ (Class)modelClassForDATA
{
    return nil;
}
#pragma mark -
#pragma mark data 类型为数组时，必须实现此类,返回此数组包含的model类型
+ (Class)itemClassForDATA
{
    return nil;
}
#pragma mark -
#pragma mark 发起网络请求
- (void)startRequestWithSuccess:(YTKRequestCompletionBlock)success
                        failure:(YTKRequestCompletionBlock)failure
                    networkFail:(YTKRequestCompletionBlock)networkFail
{
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [kMainWindow dismiss];
        if (self.isSuccess) {
            if (success) {
                success(self);
            }
        }else{
            [self failCodeHandle];
            [kMainWindow showText:self.message];
            if (failure) {
                failure(self);
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [kMainWindow dismiss];
        [kMainWindow showText:@"网络开小差了~"];
        if (networkFail) {
            networkFail(self);
        }
    }];
    
}
- (void)startRequestWithSuccess:(YTKRequestCompletionBlock)success
                        failure:(YTKRequestCompletionBlock)failure
{
    [self startRequestWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (success) {
            success(self);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure(self);
        }
    } networkFail:NULL];
}

- (void)startRequestWithSuccess:(YTKRequestCompletionBlock)success
{
    [self startRequestWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (success) {
            success(self);
        }
    } failure:NULL];
}

///错误码的特殊处理
- (void)failCodeHandle
{
    if ([self.code isEqualToString:@"203"]||[self.code isEqualToString:@"201"]||[self.code isEqualToString:@"202"]) {
        
        AlertView *alert = [[AlertView alloc]initWithTitle:@"警告" detail:self.message actionItems:@"确认", nil];
        alert.handler = ^(NSInteger index) {
//            [[PAHUserManager share] logOut];
        } ;
        [alert show];
    }
}
@end
