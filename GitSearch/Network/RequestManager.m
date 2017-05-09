//
//  RequestManager.m
//  GitSearch
//
//  Created by changjian on 2017/5/9.
//  Copyright © 2017年 changjian. All rights reserved.
//

#import "RequestManager.h"

#define HOSTURL @"https://api.github.com/"

@implementation RequestManager

+ (void)userInfoWithUserName:(NSString *)userName
                     success:(HttpRequestSuccessBlock)successHandler
                     failure:(HttpRequestFailureBlock)failHandler {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@",HOSTURL,@"search/users?",@"q=",userName];
    [MISHttpRequest GET:url params:nil success:^(id responseData) {
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
    
    [MISHttpRequest GET:url params:nil success:^(NSArray *responseData) {
        successHandler ? successHandler(responseData) : nil;
    } failure:^(NSError *error) {
        failHandler ? failHandler(error) : nil;
    }];
}

@end
