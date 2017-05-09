//
//  MISHtttpRequest.m
//  MIS-CRM
//
//  Created by changjian on 16/4/1.
//  Copyright © 2016年 58. All rights reserved.
//

#import "MISHttpRequest.h"

typedef NS_ENUM(NSUInteger, HttpRequestType) {
    HttpRequestTypeGET = 0,
    HttpRequestTypePOST
};

// 请求超时间隔
static CGFloat const kTimeoutInterval = 30.0f;

@interface MISHttpRequest ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation MISHttpRequest

- (instancetype)init {
    
    if (self = [super init]) {
        
        // 1.创建SessionManager
        self.sessionManager = [AFHTTPSessionManager manager];
        self.sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.sessionManager.requestSerializer.timeoutInterval = kTimeoutInterval;
        self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];/
        
    }
    return self;
}

static MISHttpRequest *instance = nil;
+ (instancetype)sharedInstance {
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [self new];
    });
    
    return instance;
}


+ (void)GET:(NSString *)url
     params:(NSDictionary *)params
    success:(HttpRequestSuccessBlock)successHandler
    failure:(HttpRequestFailureBlock)failureHandler {
    
    [MISHttpRequest requestMethod:HttpRequestTypeGET
                              url:url
                           params:params
                          success:successHandler
                          failure:failureHandler];
    
}

+ (void)POST:(NSString *)url
      params:(NSDictionary *)params
     success:(HttpRequestSuccessBlock)successHandler
     failure:(HttpRequestFailureBlock)failureHandler {
    
    [MISHttpRequest requestMethod:HttpRequestTypePOST
                              url:url
                           params:params
                          success:successHandler
                          failure:failureHandler];
    
}

+ (void)requestMethod:(HttpRequestType)requestType
                  url:(NSString *)url
               params:(NSDictionary *)params
              success:(HttpRequestSuccessBlock)successHandler
              failure:(HttpRequestFailureBlock)failureHandler {
    
    if ([MISHttpRequest sharedInstance].timeoutInterval > 0) {
        [MISHttpRequest sharedInstance].sessionManager.requestSerializer.timeoutInterval = [MISHttpRequest sharedInstance].timeoutInterval;
    }

    
    // *********** 发送请求 ***********
    switch (requestType) {
        case HttpRequestTypeGET: {   // GET请求
            
            [[MISHttpRequest sharedInstance].sessionManager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSError *err;
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
                
                if (successHandler && (!err)) {
                    successHandler ? successHandler(responseDict) : nil;
                }

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureHandler ? failureHandler(error) : nil;

            }];
            
            break;
        }
        case HttpRequestTypePOST: {  // POST请求
            
            [[MISHttpRequest sharedInstance].sessionManager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError *err;
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
                if (successHandler && (!err)) {
                    
                    successHandler ? successHandler(responseDict) : nil;
                } else {
                    failureHandler ? failureHandler(err) : nil;
                }

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureHandler ? failureHandler(error) : nil;

            }];
            
            break;
        }
        default:
            break;
    }
    
}
@end
