//
//  Consts.h
//  MIS58
//
//  Created by changjian on 16/7/1.
//  Copyright © 2016年 58.com. All rights reserved.
//

#ifndef Consts_h
#define Consts_h

#define STRONGSELF()  __strong typeof(weakSelf)strongSelf = weakSelf
#define BLOCKSELF() __block __typeof(&*self)blockSelf = self
#define WEAKSELF() __weak __typeof(&*self)weakSelf = self

#define SCREEN_WIDTH  CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCREEN_HEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])
#define kHEIGHTSCALE  (([UIScreen mainScreen].bounds.size.height) / 568)
#define kWITHSCALE  (([UIScreen mainScreen].bounds.size.width) / 320)

#define TABLEVIEW_HEADER_LINE_HEIGHT           0.01f
#define UI_SINGLELINE                          (0.5)
#define NAV_BAR_HEIGHT                         64.0f
#define CUSTOM_LABEL_HEIGHT                    21.0f
#define CUSTOM_CELL_HEIGHT                     45.0f
#define UI_SCREEN_SCALE ([[UIScreen mainScreen] scale])
#define TITLE_VIEW_FONT_SIZE                    17.0f
#define CUSTOME_FONT_SIZE                       15.0f
#define SearchDefaultTextFont [UIFont systemFontOfSize:9.0f]

#define TOP_VIEW  [[UIApplication sharedApplication] keyWindow].rootViewController.view

#define iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define CurrentDeviceVersion  [[[UIDevice currentDevice] systemVersion] floatValue]

#define IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue]) >= 6.0 && ([[[UIDevice currentDevice] systemVersion] floatValue]) < 7.0

#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue]) >= 7.0

#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue]) >= 8.0

#define IOS8ONLY ([[[UIDevice currentDevice] systemVersion] floatValue]) >= 8.0 && ([[[UIDevice currentDevice] systemVersion] floatValue]) < 9.0


#define VERSION_HIGHER_THAN_IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

//判断iphone4S

#define s_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iphone5S

#define s_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iphone6

#define s_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iphone6+

#define s_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iPhone6P放大模式
#define iPhone6PlusZoom ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)

#define kRightIndex @"kRightIndex"

// 日志输出
#ifndef __OPTIMIZE__
#define NSLog(fmt, ...) NSLog((@"[%s Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

#endif /* Consts_h */
