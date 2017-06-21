//
//  HXPaginationView.h
//  HXPaginationView
//
//  Created by xing on 2017/6/20.
//  Copyright © 2017年 xing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXPaginationStyle;

@interface HXPaginationView : UIView

+ (instancetype)viewWithFrame:(CGRect)frame titles:(NSArray *)titles childViewControllers:(NSArray *)childViewControllers parentViewController:(UIViewController *)parentViewController style:(HXPaginationStyle *)style;

@end

