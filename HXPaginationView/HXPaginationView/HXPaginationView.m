//
//  HXPaginationView.m
//  HXPaginationView
//
//  Created by xing on 2017/6/20.
//  Copyright © 2017年 xing. All rights reserved.
//

#import "HXPaginationView.h"
#import "HXPaginationStyle.h"
#import "HXPaginationTitleView.h"
#import "HXPaginationContentView.h"
#import "UIColor+PaginationExtension.h"

@interface HXPaginationView ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *childViewControllers;
@property (nonatomic, strong) UIViewController *parentViewController;
@property (nonatomic, strong) HXPaginationStyle *style;
@property (nonatomic, strong) HXPaginationTitleView *titleView;
@property (nonatomic, strong) HXPaginationContentView *contentView;

@end

@implementation HXPaginationView

+ (instancetype)viewWithFrame:(CGRect)frame titles:(NSArray *)titles childViewControllers:(NSArray *)childViewControllers parentViewController:(UIViewController *)parentViewController style:(HXPaginationStyle *)style {
    HXPaginationView *view = [[self alloc] initWithFrame:frame];
    
    view.titles = titles;
    view.childViewControllers = childViewControllers;
    view.parentViewController = parentViewController;
    view.style = style;
    
    [view setupSubViews];
    
    return view;
}

- (void)setupSubViews {
    [self setupTitleView];
    [self setupContentView];
}

- (void)setupTitleView {
    CGRect frame = CGRectMake(0, 0, self.bounds.size.width, _style.titleHeight);
    _titleView = [HXPaginationTitleView viewWithFrame:frame titles:_titles style:_style];
    
    [self addSubview:_titleView];
    
    _titleView.backgroundColor = [UIColor randomColor];
}

- (void)setupContentView {
    CGRect frame = CGRectMake(0, _style.titleHeight, self.bounds.size.width, self.bounds.size.height - _style.titleHeight);
    
    _contentView = [HXPaginationContentView viewWithFrame:frame childViewControllers:_childViewControllers parentViewController:_parentViewController];
    
    _titleView.delegate = _contentView;
    _contentView.delegate = self.titleView;
    
    
    [self addSubview:_contentView];
    
    _contentView.backgroundColor = [UIColor randomColor];
}

@end
