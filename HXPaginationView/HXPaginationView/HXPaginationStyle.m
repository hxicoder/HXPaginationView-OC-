//
//  HXPaginationStyle.m
//  HXPaginationView
//
//  Created by xing on 2017/6/20.
//  Copyright © 2017年 xing. All rights reserved.
//

#import "HXPaginationStyle.h"
#import "UIColor+PaginationExtension.h"

@implementation HXPaginationStyle

- (instancetype)init {
    if (self = [super init]) {
        _titleHeight = 44;
        _normalColor = [UIColor colorWithR:0 g:0 b:0 alpha:1.0];
        _selectColor = [UIColor colorWithR:255 g:127 b:0 alpha:1.0];
        
        _isScrollEnable = NO;
        
        _isShowScrollLine = NO;
        _scrollLineHeight = 2;
        _scrollLineColor = [UIColor orangeColor];
        
        _itemMargin = 30;
        _fontSize = 15;
    }
    
    return self;
}

@end
