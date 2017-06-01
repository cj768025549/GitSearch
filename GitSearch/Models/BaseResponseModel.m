//
//  BaseResponseModel.m
//  GitSearch
//
//  Created by changjian on 2017/5/9.
//  Copyright © 2017年 changjian. All rights reserved.
//

#import "BaseResponseModel.h"

@implementation BaseResponseModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"items":@"UserInfoModel"};
}

@end
