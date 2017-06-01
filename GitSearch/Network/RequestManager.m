//
//  RequestManager.m
//  GitSearch
//
//  Created by changjian on 2017/5/9.
//  Copyright © 2017年 changjian. All rights reserved.
//

#import "RequestManager.h"

#define HOSTURL         @"https://api.github.com/"
#define CLIENTID        @"81fc3c9fec9680e8bf95"
#define CLIENTSECRET    @"91bfac765d6cbddcfb929bedc34257ff549c47bd"

@implementation RequestManager

+ (void)userInfoWithUserName:(NSString *)userName
                     success:(HttpRequestSuccessBlock)successHandler
                     failure:(HttpRequestFailureBlock)failHandler {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@",HOSTURL,@"search/users?",@"q=",userName];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:CLIENTID forKey:@"client_id"];
    [param setObject:CLIENTSECRET forKey:@"client_secret"];
    [MISHttpRequest GET:url params:param success:^(id responseData) {
        BaseResponseModel *model = [BaseResponseModel mj_objectWithKeyValues:responseData];
        successHandler ? successHandler(model) : nil;
    } failure:^(NSError *error) {
        failHandler ? failHandler(error) : nil;
    }];

}

+ (void)userReponsWithUserName:(NSString *)userName
                       success:(HttpRequestSuccessBlock)successHandler
                       failure:(HttpRequestFailureBlock)failHandler {

    NSString *url = [NSString stringWithFormat:@"%@%@%@%@",HOSTURL,@"users/",userName,@"/repos"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:CLIENTID forKey:@"client_id"];
    [param setObject:CLIENTSECRET forKey:@"client_secret"];

    [MISHttpRequest GET:url params:param success:^(NSArray *responseData) {
        successHandler ? successHandler(responseData) : nil;
    } failure:^(NSError *error) {
        failHandler ? failHandler(error) : nil;
    }];
}

@end
