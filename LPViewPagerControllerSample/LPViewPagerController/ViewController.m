//
//  ViewController.m
//  LPViewPagerController
//
//  Created by litt1e-p on 15/12/5.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "ViewController.h"
#import "LPTitleView.h"
#import "TableVc1.h"
#import "TableVc2.h"
#import "TableVc3.h"

@interface ViewController ()<LPViewPagerDataSource, LPViewPagerDelegate, LPTitleViewDelegate>

@property (nonatomic, strong) TableVc1 *tableVc1;
@property (nonatomic, strong) TableVc2 *tableVc2;
@property (nonatomic, strong) TableVc3 *tableVc3;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) LPTitleView *pagingTitleView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = self;
    self.delegate = self;
    
    // Do not auto load data
    self.manualLoadData = YES;
    self.currentIndex = 0;
    self.navigationItem.titleView = self.pagingTitleView;
    [self reloadData];
}

#pragma mark - LPViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(LPViewPagerController *)viewPager
{
    return 3;
}

- (UIViewController *)viewPager:(LPViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    if (index == 0) {
        return [self createVc1];
    } else if (index == 1) {
        return [self createVc2];
    } else {
        return [self createVc3];
    }
}

#pragma mark 🎈LPViewPagerDelegate
- (void)viewPager:(LPViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index
{
    self.currentIndex = index;
}

- (LPTitleView *)pagingTitleView
{
    if (!_pagingTitleView) {
        self.pagingTitleView          = [[LPTitleView alloc] init];
        self.pagingTitleView.frame    = CGRectMake(0, 0, 0, 40);
        self.pagingTitleView.font     = [UIFont systemFontOfSize:15];
//        self.pagingTitleView.titleNormalColor = [UIColor greenColor];
//        self.pagingTitleView.titleSelectedColor = [UIColor yellowColor];
        self.pagingTitleView.indicatorColor = [UIColor purpleColor];
        NSArray *titleArray           = @[@"Title1", @"Title2", @"Title3"];
        CGRect ptRect                 = self.pagingTitleView.frame;
        ptRect.size.width             = [LPTitleView calcTitleWidth:titleArray withFont:self.pagingTitleView.font];
        self.pagingTitleView.frame    = ptRect;
        [self.pagingTitleView addTitles:titleArray];
        self.pagingTitleView.delegate = self;
    }
    return _pagingTitleView;
}

- (void)didSelectedTitleAtIndex:(NSUInteger)index
{
    UIPageViewControllerNavigationDirection direction;
    if (self.currentIndex == index) {
        return;
    }
    if (index > self.currentIndex) {
        direction = UIPageViewControllerNavigationDirectionForward;
    } else {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    UIViewController *viewController = [self viewControllerAtIndex:index];
    if (viewController) {
        __weak typeof(self) weakself = self;
        [self.pageViewController setViewControllers:@[viewController] direction:direction animated:YES completion:^(BOOL finished) {
            weakself.currentIndex = index;
        }];
    }
}

- (void)setCurrentIndex:(NSInteger)index
{
    _currentIndex = index;
    [self.pagingTitleView adjustTitleViewAtIndex:index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat screenWidth = [[UIScreen mainScreen]bounds].size.width;
    if (self.currentIndex != 0 && contentOffsetX <= screenWidth * 2) {
        contentOffsetX += screenWidth * self.currentIndex;
    }
    [self.pagingTitleView updatePageIndicatorPosition:contentOffsetX];
}

- (void)scrollEnabled:(BOOL)enabled
{
    self.scrollingLocked = !enabled;
    for (UIScrollView *view in self.pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.scrollEnabled = enabled;
            view.bounces = enabled;
        }
    }
}

#pragma mark - lazy load

- (UIViewController *)createVc1
{
    if (!self.tableVc1) {
        self.tableVc1 = [[TableVc1 alloc] init];
    }
    return self.tableVc1;
}

- (UIViewController *)createVc2
{
    if (!self.tableVc2) {
        self.tableVc2 = [[TableVc2 alloc] init];
    }
    return self.tableVc2;
}

- (UIViewController *)createVc3
{
    if (!self.tableVc3) {
        self.tableVc3 = [[TableVc3 alloc] init];
    }
    return self.tableVc3;
}

@end
