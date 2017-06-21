//
//  HXPaginationTitleView.h
//  HXPaginationView
//
//  Created by xing on 2017/6/20.
//  Copyright © 2017年 xing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXPaginationStyle.h"
#import "HXPaginationContentView.h"
#import "HXPaginationContentViewDelegate.h"
#import "HXPaginationTitleViewDelegate.h"

@interface HXPaginationTitleView : UIView <HXPaginationContentViewDelegate>

@property (nonatomic, weak) id <HXPaginationTitleViewDelegate> delegate;

+ (instancetype)viewWithFrame:(CGRect)frame titles:(NSArray *)titles style:(HXPaginationStyle *)style;

@end
