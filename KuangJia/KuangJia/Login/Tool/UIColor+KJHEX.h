//
//  UIColor+KJHEX.h
//  KuangJia
//
//  Created by XB on 2018/11/2.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (KJHEX)

/**
 * 根据str生成颜色
 * @param str red，yellow，#FFFFFF，
 * @return
 */

+ (UIColor *)kj_colorFromString:(NSString *)str;


/**
 *根据str生成颜色 根据alpha空值透明度 透明度只限制在 str是3位和6位的字符串
 
 @param str 色值字符串 如果是六位字符串 要加#
 @param alpha 透明度
 @return 色值
 */
+ (UIColor *)kj_colorFromString:(NSString *)str alpha:(CGFloat)alpha;
@end

