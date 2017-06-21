//
//  ViewController.m
//  HXPaginationView
//
//  Created by xing on 2017/6/20.
//  Copyright © 2017年 xing. All rights reserved.
//

#import "ViewController.h"
#import "HXPaginationStyle.h"
#import "HXPaginationView.h"
#import "UIColor+PaginationExtension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 1.标题
    //        let titles = ["游戏", "娱乐", "趣玩", "美女", "颜值"]
    NSArray *titles = @[@"游戏", @"娱乐娱乐娱乐", @"趣玩", @"美女女", @"颜值颜值", @"趣玩", @"美女女", @"颜值颜值"];
    HXPaginationStyle *style = [[HXPaginationStyle alloc] init];
    style.isScrollEnable = YES;
    style.isShowScrollLine = YES;
    
    NSMutableArray *childVcs = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor randomColor];
        [childVcs addObject:vc];
    }
    
    CGRect pageFrame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    
    HXPaginationView *pageView = [HXPaginationView viewWithFrame:pageFrame titles:titles childViewControllers:childVcs parentViewController:self style:style];
    [self.view addSubview:pageView];
}

@end
