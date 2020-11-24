//
//  XXImageBrowser.m
//  demo
//
//  Created by liusui on 2020/11/4.
//  Copyright © 2020 Ranka. All rights reserved.
//

#define kMinZoomScale 1.0f
#define kMaxZoomScale 2000.0f

#import "XXImageBrowser.h"
#import "UIViewController+currentVC.h"

@interface XXImageBrowser () <UIScrollViewDelegate>
@property(nonatomic, strong) UIView *mySuperView;

@end

@implementation XXImageBrowser

#pragma mark recyle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = NO;
        [self addSubview:self.scrollview];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _scrollview.frame = self.bounds;
    [self adjustFrame];
}

#pragma mark getter setter
- (UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] init];
        _scrollview.frame = self.bounds;
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        self.imageview.frame = self.bounds;
        [_scrollview addSubview:self.imageview];
        _scrollview.delegate = self;
        _scrollview.clipsToBounds = NO;
    }
    return _scrollview;
}

- (UIImageView *)imageview
{
    if (!_imageview) {
        _imageview = [[UIImageView alloc] init];
        _imageview.frame = self.bounds;
        _imageview.clipsToBounds = NO;
        _imageview.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageview;
}

- (void)adjustFrame
{
//    CGRect frame = self.frame;
//    frame.origin = CGPointZero;
//    self.imageview.frame = frame;
//    self.scrollview.contentSize = self.imageview.frame.size;
    [self setupImageScale];
}

- (void)setupImageScale {
    self.scrollview.minimumZoomScale = kMinZoomScale;
    self.scrollview.maximumZoomScale = kMaxZoomScale;
    self.scrollview.zoomScale = 1.0f;
    self.scrollview.bouncesZoom = NO;
}

#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageview;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    [self.mySuperView addSubview:self];
    if (scale == 1) {
        [self setupImageScale];
        self.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        self.scrollview.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        self.imageview.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            [self setupImageScale];
            self.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
            self.scrollview.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
            self.imageview.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {
    if (self.mySuperView == nil) {
        self.mySuperView = self.superview;
    }
    CGRect frame = [self convertRect:self.bounds toView:[UIViewController currentViewController].view];
    self.frame = frame;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

@end
