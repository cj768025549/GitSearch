//
//  UserInfoModel.m
//  GitSearch
//
//  Created by changjian on 2017/5/9.
//  Copyright © 2017年 changjian. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"userName":@"login"};
}

@end
