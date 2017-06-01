//
//  UserInfoModel.h
//  GitSearch
//
//  Created by changjian on 2017/5/9.
//  Copyright © 2017年 changjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic, copy, readonly) NSString *avatar_url;
@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, copy) NSString *language;

@end
