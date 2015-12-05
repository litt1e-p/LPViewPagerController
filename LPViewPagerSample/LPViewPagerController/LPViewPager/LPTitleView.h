//
//  LPTitleView.h
//  LPViewPagerController
//
//  Created by litt1e-p on 15/12/5.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPTitleViewDelegate <NSObject>

@optional
- (void)didSelectedTitleAtIndex:(NSUInteger)index;

@end

@interface LPTitleView : UIView

@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, weak) id<LPTitleViewDelegate> delegate;

- (void)addTitles:(NSArray *)titles;
- (void)adjustTitleViewAtIndex:(CGFloat)index;
+ (CGFloat)calcTitleWidth:(NSArray *)titleArr withFont:(UIFont *)titleFont;
- (void)updatePageIndicatorPosition:(CGFloat)xPosition;

@end
