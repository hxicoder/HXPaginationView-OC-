//
//  HXPaginationTitleView.m
//  HXPaginationView
//
//  Created by xing on 2017/6/20.
//  Copyright © 2017年 xing. All rights reserved.
//

#import "HXPaginationTitleView.h"
#import "UIColor+PaginationExtension.h"

@interface HXPaginationTitleView () <HXPaginationContentViewDelegate>

@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) HXPaginationStyle *style;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray <UILabel *> *titleLabels;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation HXPaginationTitleView

- (NSMutableArray<UILabel *> *)titleLabels {
    if (_titleLabels == nil) {
        _titleLabels = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _titleLabels;
}

+ (instancetype)viewWithFrame:(CGRect)frame titles:(NSArray *)titles style:(HXPaginationStyle *)style {
    HXPaginationTitleView *view = [[self alloc] initWithFrame:frame];
    
    view.titles = titles;
    view.style = style;
    
    [view setupSubViews];
    
    return view;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
    }
    
    return _scrollView;
}

- (UIView *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = self.style.scrollLineColor;
        CGRect frame = CGRectMake(0, self.bounds.size.height - self.style.scrollLineHeight, 0, self.style.scrollLineHeight);
        _bottomLine.frame = frame;
    }
    
    return _bottomLine;
}

- (void)setupSubViews {
    [self addSubview:self.scrollView];
    
    [self setupTitleLabels];
    
    [self setupTitleLabelsFrame];
    
    if (_style.isShowScrollLine) {
        [self.scrollView addSubview:self.bottomLine];
    }
}


- (void)setupTitleLabels {
    for (int i = 0; i < _titles.count; i++) {
        NSString *title = _titles[i];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = title;
        titleLabel.font = [UIFont systemFontOfSize:_style.fontSize];
        titleLabel.tag = i;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = ((i == 0) ? _style.selectColor : _style.normalColor);
        
        [self.scrollView addSubview:titleLabel];
        [self.titleLabels addObject:titleLabel];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)];
        [titleLabel addGestureRecognizer:tapGes];
        titleLabel.userInteractionEnabled = YES;
    }
}

- (void)setupTitleLabelsFrame {
    NSInteger count = _titles.count;
    
    for (int i = 0; i < count; i++) {
        UILabel *label = _titleLabels[i];
        CGFloat w = 0;
        CGFloat h = self.bounds.size.height;
        CGFloat x = 0;
        CGFloat y = 0;
        
        if (_style.isScrollEnable) {
            w = [_titles[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : label.font} context:nil].size.width;
            
            if (i == 0) {
                x = _style.itemMargin * 0.5;
                if (_style.isShowScrollLine) {
                    self.bottomLine.frame = CGRectMake(x, self.bottomLine.frame.origin.y, w, _style.scrollLineHeight);
                }
            } else {
                UILabel *preLabel = _titleLabels[i - 1];
                x = CGRectGetMaxX(preLabel.frame) + _style.itemMargin;
            }
        } else {
            w = self.bounds.size.width / count;
            x = w * i;
            
            if (i == 0 && _style.isShowScrollLine) {
                self.bottomLine.frame = CGRectMake(0, self.bottomLine.frame.origin.y, w, _style.scrollLineHeight);
            }
        }
        
        label.frame = CGRectMake(x, y, w, h);
    }

    self.scrollView.contentSize = _style.isScrollEnable ? CGSizeMake(CGRectGetMaxX(_titleLabels.lastObject.frame) + _style.itemMargin * 0.5, 0) : CGSizeZero;
}

- (void)titleLabelClick:(UITapGestureRecognizer *)tapGes {
    UILabel *targetLabel = (UILabel *)tapGes.view;
    
    [self adjustTitleLabel:targetLabel.tag];
    
    if (_style.isShowScrollLine) {
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomLine.frame = CGRectMake(targetLabel.frame.origin.x, _bottomLine.frame.origin.y, targetLabel.frame.size.width, _style.scrollLineHeight);
        }];
    }
    
    if ([self.delegate respondsToSelector:@selector(titleView:targetIndex:)]) {
        [self.delegate titleView:self targetIndex:(int)_currentIndex];
    }
}

- (void)adjustTitleLabel:(NSInteger)targetIndex {
    if (targetIndex == _currentIndex) {
        return;
    }
    
    UILabel *targetLabel = _titleLabels[targetIndex];
    UILabel *sourceLabel = _titleLabels[_currentIndex];
    
    // 2.切换文字的颜色
    targetLabel.textColor = _style.selectColor;
    sourceLabel.textColor = _style.normalColor;
    
    // 3.记录下标值
    _currentIndex = targetIndex;
    
    // 4.调整位置
    if (_style.isScrollEnable) {
        CGFloat offsetX = targetLabel.center.x - _scrollView.bounds.size.width * 0.5;
        if (offsetX < 0) {
            offsetX = 0;
        }
        if (offsetX > (_scrollView.contentSize.width - _scrollView.bounds.size.width)) {
            offsetX = _scrollView.contentSize.width - _scrollView.bounds.size.width;
        }
        
        [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}

- (void)contentView:(HXPaginationContentView *)contentView targetIndex:(int)targetIndex {
    [self adjustTitleLabel:targetIndex];
}

- (void)contentView:(HXPaginationContentView *)contentView targetIndex:(int)targetIndex progress:(CGFloat)progress {
    UILabel *targetLabel = _titleLabels[targetIndex];
    UILabel *sourceLabel = _titleLabels[_currentIndex];
    
    NSArray *deltaRGB = [UIColor getRGBDelta:_style.selectColor seccondColor:_style.normalColor];
    
    const CGFloat *selectRGB = [_style.selectColor getRGB];
    const CGFloat *normalRGB = [_style.normalColor getRGB];
    
    targetLabel.textColor = [UIColor colorWithR:normalRGB[0] * 255 + ((NSNumber *)deltaRGB[0]).floatValue * progress g:normalRGB[1] * 255 + ((NSNumber *)deltaRGB[1]).floatValue * progress b:normalRGB[2] * 255 + ((NSNumber *)deltaRGB[2]).floatValue * progress alpha:1.0];
    sourceLabel.textColor = [UIColor colorWithR:selectRGB[0] * 255 - ((NSNumber *)deltaRGB[0]).floatValue * progress g:selectRGB[1] * 255 - ((NSNumber *)deltaRGB[1]).floatValue * progress b:selectRGB[2] * 255 - ((NSNumber *)deltaRGB[2]).floatValue * progress alpha:1.0];
    
    if (_style.isShowScrollLine) {
        CGFloat deltaX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x;
        CGFloat deltaW = targetLabel.frame.size.width - sourceLabel.frame.size.width;
        
        _bottomLine.frame = CGRectMake(sourceLabel.frame.origin.x + deltaX * progress, _bottomLine.frame.origin.y, sourceLabel.frame.size.width + deltaW * progress, _bottomLine.frame.size.height);
    }
}

@end
