//
//  HXPaginationStyle.h
//  HXPaginationView
//
//  Created by xing on 2017/6/20.
//  Copyright © 2017年 xing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HXPaginationStyle : NSObject

@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat scrollLineHeight;
@property (nonatomic, assign) CGFloat itemMargin;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectColor;
@property (nonatomic, strong) UIColor *scrollLineColor;

/**
 标题栏滚动标识 NO: 不能滚动 YES: 支持滚动
 */
@property (nonatomic, assign) BOOL isScrollEnable;

/**
 底部线显示标识 false: 不显示 true: 显示
 */
@property (nonatomic, assign) BOOL isShowScrollLine;

@end
