//
//  LPViewPagerController.h
//  LPViewPagerController
//
//  Created by litt1e-p on 15/12/5.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ViewPagerOption) {
    ViewPagerOptionTabHeight,
    ViewPagerOptionTabOffset,
    ViewPagerOptionTabWidth,
    ViewPagerOptionTabLocation,
    ViewPagerOptionStartFromSecondTab,
    ViewPagerOptionCenterCurrentTab
};

@protocol LPViewPagerDataSource;
@protocol LPViewPagerDelegate;

@interface LPViewPagerController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, weak) id<LPViewPagerDataSource> dataSource;
@property (nonatomic, weak) id<LPViewPagerDelegate> delegate;

@property UIPageViewController *pageViewController;

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index;

#pragma mark 🎈ViewPagerOptions

// 1.0: YES, 0.0: NO, defines if view should appear with the second or the first tab
// Defaults to NO
@property NSUInteger showFromTabIndex;

#pragma mark Colors
@property UIColor *contentViewBackgroundColor;

@property (nonatomic) BOOL manualLoadData;
@property (nonatomic) BOOL scrollingLocked;
#pragma mark Methods
// Reload all tabs and contents
- (void)reloadData;

@end

#pragma mark 🎈dataSource
@protocol LPViewPagerDataSource <NSObject>

// Asks dataSource how many tabs will be
- (NSUInteger)numberOfTabsForViewPager:(LPViewPagerController *)viewPager;

@optional
// The content for any tab. Return a view controller and ViewPager will use its view to show as content
- (UIViewController *)viewPager:(LPViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index;
- (UIView *)viewPager:(LPViewPagerController *)viewPager contentViewForTabAtIndex:(NSUInteger)index;

@end

#pragma mark 🎈delegate
@protocol LPViewPagerDelegate <NSObject>

@optional
// delegate object must implement this method if wants to be informed when a tab changes
- (void)viewPager:(LPViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index;
// Every time - reloadData called, ViewPager will ask its delegate for option values
// So you don't have to set options from ViewPager itself
- (CGFloat)viewPager:(LPViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value;

- (void)setSubViewScrollStatus:(BOOL)enabled;

@end