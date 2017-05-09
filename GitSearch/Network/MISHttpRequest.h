//
//  MISHtttpRequest.h
//  MIS-CRM
//
//  Created by changjian on 16/4/1.
//  Copyright © 2017年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>

/**
 *  请求成功block
 */
typedef void (^HttpRequestSuccessBlock)(id responseData);

/**
 *  请求失败block
 */
typedef void (^HttpRequestFailureBlock) (NSError *error);

/**
 *  请求响应block
 */
typedef void (^HttpResponseBlock)(id dataObj, NSError *error);

@interface MISHttpRequest : NSObject

/**
 *  请求超时时间
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 *  创建单例请求对象
 */
+ (instancetype)sharedInstance;

/**
 *  GET请求 -> 默认只请求数据，不做缓存。HttpRequestDefault方式
 *
 *  @param url            请求路径
 *  @param params         请求参数
 *  @param successHandler 请求成功后的回调
 *  @param failureHandler 请求失败后的回调
 */
+ (void)GET:(NSString *)url
     params:(NSDictionary *)params
    success:(HttpRequestSuccessBlock)successHandler
    failure:(HttpRequestFailureBlock)failureHandler;

/**
 *  POST请求 -> 默认只请求数据，不做缓存。HttpRequestDefault方式
 *
 *  @param url            请求路径
 *  @param params         请求参数
 *  @param successHandler 请求成功后的回调
 *  @param failureHandler 请求失败后的回调
 */
+ (void)POST:(NSString *)url
      params:(NSDictionary *)params
     success:(HttpRequestSuccessBlock)successHandler
     failure:(HttpRequestFailureBlock)failureHandler;

@end
