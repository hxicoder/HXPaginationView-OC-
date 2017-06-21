//
//  HXPaginationContentViewDelegate.h
//  HXPaginationView
//
//  Created by xing on 2017/6/21.
//  Copyright © 2017年 xing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HXPaginationContentView;

@protocol HXPaginationContentViewDelegate <NSObject>

- (void)contentView:(HXPaginationContentView *)contentView targetIndex:(int)targetIndex;
- (void)contentView:(HXPaginationContentView *)contentView targetIndex:(int)targetIndex progress:(CGFloat)progress;

@end
