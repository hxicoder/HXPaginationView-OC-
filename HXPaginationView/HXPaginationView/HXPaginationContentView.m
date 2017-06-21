//
//  HXPaginationContentView.m
//  HXPaginationView
//
//  Created by xing on 2017/6/20.
//  Copyright © 2017年 xing. All rights reserved.
//

#import "HXPaginationContentView.h"
#import "UIColor+PaginationExtension.h"

static NSString *cellId = @"cellId";

@interface HXPaginationContentView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *childViewControllers;
@property (nonatomic, strong) UIViewController *parentViewController;
@property (nonatomic, assign) CGFloat startOffsetX;
@property (nonatomic, assign) BOOL isForbidScroll;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HXPaginationContentView

+ (instancetype)viewWithFrame:(CGRect)frame childViewControllers:(NSArray *)childViewControllers parentViewController:(UIViewController *)parentViewController {
    HXPaginationContentView *view = [[self alloc] initWithFrame:frame];
    
    view.childViewControllers = childViewControllers;
    view.parentViewController = parentViewController;
    
    [view setupUI];
    
    return view;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    
    return _collectionView;
}

- (void)setupUI {
    for (UIViewController *childVc in _childViewControllers) {
        [_parentViewController addChildViewController:childVc];
    }
    
    // 2.添加UICollection用于展示内容
    [self addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }

    
    UIViewController *childVc = _childViewControllers[indexPath.item];
    childVc.view.frame = cell.contentView.bounds;
    childVc.view.backgroundColor = [UIColor randomColor];
    [cell.contentView addSubview:childVc.view];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self contentEndScroll];
    scrollView.scrollEnabled = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self contentEndScroll];
    } else {
        scrollView.scrollEnabled = NO;
    }
}

- (void)contentEndScroll {
    if (_isForbidScroll) {
        return;
    }
    
    int currentIndex = _collectionView.contentOffset.x / _collectionView.bounds.size.width;
    
    if ([self.delegate respondsToSelector:@selector(contentView:targetIndex:)]) {
        [self.delegate contentView:self targetIndex:currentIndex];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isForbidScroll = NO;
    _startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_startOffsetX != scrollView.contentOffset.x && !_isForbidScroll) {
        int targetIndex = 0;
        CGFloat progress = 0.0;
        
        int currentIndex = _startOffsetX / scrollView.bounds.size.width;
        
        if (_startOffsetX < scrollView.contentOffset.x) {
            targetIndex = currentIndex + 1;
            if (targetIndex > _childViewControllers.count - 1) {
                targetIndex = (int)_childViewControllers.count - 1;
            }
            
            progress = (scrollView.contentOffset.x - _startOffsetX) / scrollView.bounds.size.width;
        } else {
            targetIndex = currentIndex - 1;
            if (targetIndex < 0) {
                targetIndex = 0;
            }
            progress = (_startOffsetX - scrollView.contentOffset.x) / scrollView.bounds.size.width;
        }
        
        if ([self.delegate respondsToSelector:@selector(contentView:targetIndex:progress:)]) {
            [self.delegate contentView:self targetIndex:targetIndex progress:progress];
        }
    }
}

- (void)titleView:(HXPaginationTitleView *)titleView targetIndex:(int)targetIndex {
    _isForbidScroll = YES;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:targetIndex inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

@end
