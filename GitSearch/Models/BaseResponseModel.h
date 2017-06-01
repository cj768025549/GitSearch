//
//  BaseResponseModel.h
//  GitSearch
//
//  Created by changjian on 2017/5/9.
//  Copyright © 2017年 changjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResponseModel : NSObject

@property (nonatomic, strong, readonly) NSNumber *total_count;

@property (nonatomic, assign, getter=isIncomplete_results) BOOL incomplete_results;
/**
 item装UserInfoModel
 **/
@property (nonatomic, copy, readonly) NSArray *items;

@end
