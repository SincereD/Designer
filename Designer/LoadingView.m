//
//  LoadingView.m
//  Designer
//
//  Created by Sincere on 16/5/20.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "LoadingView.h"
#import <UIImageView+PlayGIF.h>

@interface LoadingView ()
{
    UIImageView * _gifImageView;
    UIView * _baseView;
}
@end

@implementation LoadingView

- (instancetype)init
{
    if (self = [super init])
    {
        [self setFrame:[UIScreen mainScreen].bounds];
        [self setClipsToBounds:YES];
        [self baseView];
        [self gifView];
    }
    return self;
}

- (void)baseView
{
    _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [_baseView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_baseView];
}

- (void)gifView
{
    _gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 6 / 8)];
    _gifImageView.center = _baseView.center;
    [_gifImageView setGifPath:[[NSBundle mainBundle] pathForResource:@"Loading" ofType:@"gif"]];
    [_gifImageView setUserInteractionEnabled:YES];
    [_baseView addSubview:_gifImageView];
}

- (void)showOnView:(UIView*)baseView
{
    [_gifImageView setFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 6 / 8)];
    _gifImageView.center = CGPointMake(-kScreenWidth/2.0f, kScreenHeight/2.0f);
    [baseView addSubview:self];
    [_gifImageView startGIF];

    [UIView animateKeyframesWithDuration:1.5f delay:0 options:UIViewKeyframeAnimationOptionCalculationModePaced animations:^{
        _gifImageView.center = _baseView.center;
    } completion:^(BOOL finished) {

    }];
}

- (void)removeLoadingView
{
    [UIView animateKeyframesWithDuration:1.5f delay:0 options:UIViewKeyframeAnimationOptionCalculationModePaced animations:^{
        self.transform = CGAffineTransformMakeTranslation(kScreenWidth, 0);
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }];
}

@end
