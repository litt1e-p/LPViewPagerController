//
//  LPTitleView.m
//  LPViewPagerController
//
//  Created by litt1e-p on 15/12/5.
//  Copyright © 2015年 litt1e-p. All rights reserved.
//

#import "LPTitleView.h"

@interface LPTitleView()

@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, strong) UIView *pageIndicator;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation LPTitleView

static CGFloat kTitleMargin = 50;

- (id)init
{
    if (self = [super init]) {
        self.views = [NSMutableArray array];
        [self addSubview:self.pageIndicator];
    }
    return self;
}

- (void)addTitles:(NSArray *)titles
{
    self.titleArray = titles;
    [self.views makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.views removeAllObjects];
    __weak typeof(self) weakself = self;
    [titles enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        if ([object isKindOfClass:[NSString class]]) {
            UILabel *textLabel                   = [[UILabel alloc] init];
            textLabel.text                       = object;
            textLabel.tag                        = idx;
            textLabel.textAlignment              = NSTextAlignmentCenter;
            textLabel.font                       = self.font;
            textLabel.userInteractionEnabled     = YES;
            UITapGestureRecognizer *tapTextLabel = [[UITapGestureRecognizer alloc] initWithTarget:weakself action:@selector(didTapTextLabel:)];
            [textLabel addGestureRecognizer:tapTextLabel];
            [weakself addSubview:textLabel];
            [weakself.views addObject:textLabel];
        }
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect idRect            = self.pageIndicator.frame;
    idRect.origin.y          = self.frame.size.height - 5;
    idRect.size.width        = (self.frame.size.width - kTitleMargin * (self.titleArray.count - 1))/self.titleArray.count;
    self.pageIndicator.frame = idRect;
    [self.views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [view sizeToFit];
        CGSize size       = view.frame.size;
        size.width        = self.frame.size.width;
        CGFloat viewWidth = (size.width - kTitleMargin * (self.titleArray.count - 1))/self.titleArray.count;
        view.frame        = CGRectMake((viewWidth + kTitleMargin) * idx, 0, viewWidth, size.height * 2);
    }];
}

- (void)didTapTextLabel:(UITapGestureRecognizer *)gestureRecognizer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedTitleAtIndex:)]) {
        [self.delegate didSelectedTitleAtIndex:gestureRecognizer.view.tag];
    }
}

+ (CGFloat)calcTitleWidth:(NSArray *)titleArr withFont:(UIFont *)titleFont
{
    return [self getMaxTitleWidthFromArray:titleArr withFont:titleFont] * 3 + kTitleMargin * 2;
}

+ (CGFloat)getMaxTitleWidthFromArray:(NSArray *)titleArray withFont:(UIFont *)titleFont
{
    CGFloat maxWidth = 0;
    for (int i = 0; i < titleArray.count; i++) {
        NSString *titleString = [titleArray objectAtIndex:i];
        CGFloat titleWidth    = [titleString sizeWithAttributes:@{NSFontAttributeName:titleFont}].width;
        if (titleWidth > maxWidth) {
            maxWidth = titleWidth;
        }
    }
    return maxWidth;
}

- (UIView *)pageIndicator
{
    if (!_pageIndicator) {
        _pageIndicator                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
    }
    _pageIndicator.backgroundColor = self.indicatorColor;
    return _pageIndicator;
}

- (void)updatePageIndicatorPosition:(CGFloat)xPosition
{
    CGFloat screenWidth            = [[UIScreen mainScreen]bounds].size.width;
    CGFloat pageIndicatorXPosition = (((xPosition - screenWidth)/screenWidth) * (self.frame.size.width - self.pageIndicator.frame.size.width))/(self.titleArray.count - 1);
    CGRect idRect                  = self.pageIndicator.frame;
    idRect.origin.x                = pageIndicatorXPosition;
    self.pageIndicator.frame       = idRect;
}

- (void)adjustTitleViewAtIndex:(CGFloat)index
{
    for (UILabel *textLabel in self.subviews) {
        if ([textLabel isKindOfClass:[UILabel class]]) {
            textLabel.textColor = self.titleNormalColor ? : [UIColor colorWithWhite:0.675 alpha:1.000];
            if (textLabel.tag == index) {
                textLabel.textColor =  self.titleSelectedColor ? : [UIColor blackColor];
            }
        }
    }
    CGRect idRect = self.pageIndicator.frame;
    if (index == 0) {
        idRect.origin.x = 0;
    } else if (index == self.titleArray.count - 1) {
        idRect.origin.x = self.frame.size.width - self.pageIndicator.frame.size.width;
    }
    self.pageIndicator.frame = idRect;
}

@end
