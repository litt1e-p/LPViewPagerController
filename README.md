# LPViewPagerController

LPViewPagerController is a tiny controller component which is base on UIPageViewController and it's easy to use.

## Usage

```swift
// conform LPViewPagerDataSource
// implement method below
- (NSUInteger)numberOfTabsForViewPager:(LPViewPagerController *)viewPager;
// and there are 2 optional method for implement
- (UIViewController *)viewPager:(LPViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index;
- (UIView *)viewPager:(LPViewPagerController *)viewPager contentViewForTabAtIndex:(NSUInteger)index;

// conform LPViewPagerDelegate and implement these optional methods below if needed
- (void)viewPager:(LPViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index;
- (CGFloat)viewPager:(LPViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value;
- (void)setSubViewScrollStatus:(BOOL)enabled;

// other properties
`there are some properties for customization just follow the sample project`
```

## Install

using cocoaPods:  

```Object-C
  pod 'LPViewPagerController', '~> 1.0.0'
```

## Screenshot

<img src="Screenshot/screenshot.gif" width=320>

## Update

-  v1.0.0 ---- first commit version
