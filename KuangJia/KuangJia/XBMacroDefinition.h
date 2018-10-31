//
//  XBMacroDefinition_h
//  FindSecret
//
//  Created by 9f on 2018/7/28.
//  Copyright © 2018年 Mac. All rights reserved.
//

#ifndef XBMacroDefinition_h
#define XBMacroDefinition_h

#define  IS_IPHONEX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define  STATUSBAR_HEIGHT      (IS_IPHONEX ? 44.f :20.f)
#define  STATUSBAR_And_NAVIGATIONBAR_HEIGHT  (IS_IPHONEX ? 88.f : 64.f)
#define  TABBAR_HEIGHT        (IS_IPHONEX ? (49.f+34.f) :49.f)

#define  BOTTOM_MARGIN        (IS_IPHONEX ? 34.f : 0.f)
#define  TOP_MARGIN        (IS_IPHONEX ? 44.f : 0.f)


#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])
// 无论支不支持横屏，只要设备横屏了，就会返回YES
#define IS_DEVICE_LANDSCAPE UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])
// 屏幕宽度，会根据横竖屏的变化而变化
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
// 屏幕宽度，跟横竖屏无关
#define DEVICE_WIDTH (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
// 屏幕高度，会根据横竖屏的变化而变化
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
// 屏幕高度，跟横竖屏无关
#define DEVICE_HEIGHT (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

// 字体相关的宏，用于快速创建一个字体对象，更多创建宏可查看 UIFont+QMUI.h
#define UIFontMake(size) [UIFont systemFontOfSize:size]
#define UIFontItalicMake(size) [UIFont italicSystemFontOfSize:size] // 斜体只对数字和字母有效，中文无效
#define UIFontBoldMake(size) [UIFont boldSystemFontOfSize:size]
#define UIFontBoldWithFont(_font) [UIFont boldSystemFontOfSize:_font.pointSize]

#endif /* XBMacroDefinition_h */
