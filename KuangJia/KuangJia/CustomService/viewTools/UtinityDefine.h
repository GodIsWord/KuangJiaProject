//
//  UtinityDefine.h
//  OLinPiKe
//
//  Created by 张义德 on 16/5/30.
//  Copyright © 2016年 alta. All rights reserved.
//

#define KSCREENSIZE ([UIScreen mainScreen].applicationFrame.size)  //屏幕尺寸 除掉状态栏的屏幕尺寸
#define SCREEN_SIZE ([UIScreen mainScreen].bounds.size)  //屏幕尺寸
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define SCREEN_DEFAULT_WIDTH 320.0

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define MaxTextFont 22
#define MidTextFont 16
#define MinTextFont 13

//苹果机型判断
#define iPhone4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


#define IOS7DEVICE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS8DEVICE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)



//#define ARTADEBUG
//宏输出函数
#ifdef ARTADEBUG
#define SFun_Log(fmt, ...) NSLog((@"%s," "[lineNum:%d]" fmt) , __FUNCTION__, __LINE__, ##__VA_ARGS__); //带函数名和行数
//#define SL_Log(fmt, ...) NSLog((@"===[lineNum:%d]" fmt), __LINE__, ##__VA_ARGS__);  //带行数
#define SL_Log(fmt, ...) NSLog((@"%s," "[lineNum:%d]" fmt) , __FUNCTION__, __LINE__, ##__VA_ARGS__);//带函数名和行数
#define SC_Log(fmt, ...) NSLog((fmt), ##__VA_ARGS__); //不带函数名和行数
#else
#define SFun_Log(fmt, ...);
#define SL_Log(fmt, ...);
#define SC_Log(fmt, ...);
#endif
