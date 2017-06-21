//
//  HXPaginationContentView.h
//  HXPaginationView
//
//  Created by xing on 2017/6/20.
//  Copyright © 2017年 xing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXPaginationTitleView.h"
#import "HXPaginationContentViewDelegate.h"
#import "HXPaginationTitleViewDelegate.h"

@interface HXPaginationContentView : UIView <HXPaginationTitleViewDelegate>

@property (nonatomic, weak) id <HXPaginationContentViewDelegate> delegate;

+ (instancetype)viewWithFrame:(CGRect)frame childViewControllers:(NSArray *)childViewControllers parentViewController:(UIViewController *)parentViewController;

@end
