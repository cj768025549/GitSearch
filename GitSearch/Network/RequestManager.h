//
//  RequestManager.h
//  GitSearch
//
//  Created by changjian on 2017/5/9.
//  Copyright © 2017年 changjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MISHttpRequest.h"
#import "UserInfoModel.h"
#import "BaseResponseModel.h"

@interface RequestManager : NSObject

+ (void)userInfoWithUserName:(NSString *)userName
                     success:(HttpRequestSuccessBlock)successHandler
                     failure:(HttpRequestFailureBlock)failHandler;

+ (void)userReponsWithUserName:(NSString *)userName
                       success:(HttpRequestSuccessBlock)successHandler
                       failure:(HttpRequestFailureBlock)failHandler;


@end
