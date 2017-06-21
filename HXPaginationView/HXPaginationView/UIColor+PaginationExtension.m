//
//  UIColor+PaginationExtension.m
//  HXPaginationView
//
//  Created by xing on 2017/6/20.
//  Copyright © 2017年 xing. All rights reserved.
//

#import "UIColor+PaginationExtension.h"

@implementation UIColor (PaginationExtension)

+ (UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:alpha];
}

+ (UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha {
    // 0xff0000
    // 1.判断字符串的长度是否符合
    if (hex.length < 6) {
        return nil;
    }
    
    // 2.将字符串转成大写
    NSString *tempHex = hex.uppercaseString;
    
    // 3.判断开头: 0x/#/##
    if ([tempHex hasPrefix:@"0x"] || [tempHex hasPrefix:@"##"]) {
        tempHex = [tempHex substringFromIndex:2];
    }
    
    if ([tempHex hasPrefix:@"#"]) {
        tempHex = [tempHex substringFromIndex:1];
    }
    
    // 4.分别取出RGB
    // FF --> 255
    NSRange range = NSMakeRange(0, 2);
    NSString *rHex = [tempHex substringWithRange:range];
    range.location = 2;
    NSString *gHex = [tempHex substringWithRange:range];
    range.location = 4;
    NSString *bHex = [tempHex substringWithRange:range];
    
    // 5.将十六进制转成数字 emoji表情
    UInt32 r = 0, g = 0, b = 0;
    [[NSScanner scannerWithString:rHex] scanHexInt:&r];
    [[NSScanner scannerWithString:gHex] scanHexInt:&g];
    [[NSScanner scannerWithString:bHex] scanHexInt:&b];
    
    return [UIColor colorWithR:r g:g b:b alpha:alpha];
}

+ (UIColor *)randomColor {
    return [UIColor colorWithR:arc4random_uniform(256) g:arc4random_uniform(256) b:arc4random_uniform(256) alpha:1.0];
}

+ (NSArray *)getRGBDelta:(UIColor *)firstColor seccondColor:(UIColor *)seccondColor {
    const CGFloat * firstRGB = [firstColor getRGB];
    const CGFloat * secondRGB = [seccondColor getRGB];
    
    return @[[NSNumber numberWithFloat:(firstRGB[0] -secondRGB[0]) * 255],
             [NSNumber numberWithFloat:(firstRGB[1] -secondRGB[1]) * 255],
             [NSNumber numberWithFloat:(firstRGB[2] -secondRGB[2]) * 255]];
}

- (const CGFloat *)getRGB {
    return CGColorGetComponents(self.CGColor);
}

@end
