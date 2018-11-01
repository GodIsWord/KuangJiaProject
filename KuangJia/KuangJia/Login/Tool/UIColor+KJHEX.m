//
//  UIColor+KJHEX.m
//  KuangJia
//
//  Created by XB on 2018/11/2.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "UIColor+KJHEX.h"

@implementation UIColor (KJHEX)

+ (UIColor *)kj_colorFromString:(NSString *)str{
    if ([[str substringToIndex:1] isEqualToString:@"#"]){
        return [self kj_colorWithHexString:str];
    }else{
        NSString *colorString = [str lowercaseString];
        
        if ([colorString isEqualToString:@"red"]){
            return [UIColor redColor];
        }else if ([colorString isEqualToString:@"blue"]){
            return [UIColor blueColor];
        }else if ([colorString isEqualToString:@"orange"]){
            return [UIColor orangeColor];
        }else if ([colorString isEqualToString:@"yellow"]){
            return [UIColor yellowColor];
        }else if ([colorString isEqualToString:@"brown"]){
            return [UIColor brownColor];
        }else if ([colorString isEqualToString:@"gray"]){
            return [UIColor grayColor];
        }else if ([colorString isEqualToString:@"green"]){
            return [UIColor greenColor];
        }else if ([colorString isEqualToString:@"purple"]){
            return [UIColor purpleColor];
        }else if ([colorString isEqualToString:@"magenta"]){
            return [UIColor magentaColor];
        }else if ([colorString isEqualToString:@"cyan"]){
            return [UIColor cyanColor];
        }else if ([colorString isEqualToString:@"white"]){
            return [UIColor whiteColor];
        }else if ([colorString isEqualToString:@"black"]){
            return [UIColor blackColor];
        }else if ([colorString isEqualToString:@"clear"]){
            return [UIColor clearColor];
        }
    }
    
    return [UIColor blackColor];
}
+ (UIColor *)kj_colorFromString:(NSString *)str alpha:(CGFloat)alpha
{
    return [self kj_colorWithHexString:str alpha:alpha];
}
+ (UIColor *)kj_colorWithHexString: (NSString *) hexString {
    return [self kj_colorWithHexString:hexString alpha:1];
}
+ (UIColor *)kj_colorWithHexString: (NSString *) hexString alpha:(CGFloat)alpha
{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat lAlpha, red, blue, green;
    lAlpha = alpha;
    switch ([colorString length]) {
            case 3: // #RGB
            //            lAlpha = 1.0f;
            red   = [self kj_colorComponentFrom: colorString start: 0 length: 1];
            green = [self kj_colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self kj_colorComponentFrom: colorString start: 2 length: 1];
            break;
            case 4: // #ARGB
            lAlpha = [self kj_colorComponentFrom: colorString start: 0 length: 1];
            red   = [self kj_colorComponentFrom: colorString start: 1 length: 1];
            green = [self kj_colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self kj_colorComponentFrom: colorString start: 3 length: 1];
            break;
            case 6: // #RRGGBB
            //            lAlpha = 1.0f;
            red   = [self kj_colorComponentFrom: colorString start: 0 length: 2];
            green = [self kj_colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self kj_colorComponentFrom: colorString start: 4 length: 2];
            break;
            case 8: // #AARRGGBB
            lAlpha = [self kj_colorComponentFrom: colorString start: 0 length: 2];
            red   = [self kj_colorComponentFrom: colorString start: 2 length: 2];
            green = [self kj_colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self kj_colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: lAlpha];
}

+ (CGFloat)kj_colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}
@end
