//
//  UIColor+PaginationExtension.h
//  HXPaginationView
//
//  Created by xing on 2017/6/20.
//  Copyright © 2017年 xing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIColor (PaginationExtension)

+ (UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;
+ (UIColor *)randomColor;
+ (NSArray *)getRGBDelta:(UIColor *)firstColor seccondColor:(UIColor *)seccondColor;
- (const CGFloat *)getRGB;

@end
