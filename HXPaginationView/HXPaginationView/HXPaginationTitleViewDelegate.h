//
//  HXPaginationTitleViewDelegate.h
//  HXPaginationView
//
//  Created by xing on 2017/6/21.
//  Copyright © 2017年 xing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HXPaginationTitleView;

@protocol HXPaginationTitleViewDelegate <NSObject>

- (void)titleView:(HXPaginationTitleView *)titleView targetIndex:(int)targetIndex;

@end
