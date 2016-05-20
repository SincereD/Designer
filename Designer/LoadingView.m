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
    [_gifImageView setFrame:CGRectMake(0, 0, 0, 0)];
    _gifImageView.center = _baseView.center;

    [baseView addSubview:self];
    
    [UIView animateWithDuration:0.5f animations:^{
        [_gifImageView setFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 6 / 8)];
        _gifImageView.center = _baseView.center;
        [_gifImageView startGIF];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)removeLoadingView
{
    [UIView animateKeyframesWithDuration:1.0f delay:1.0f options:UIViewKeyframeAnimationOptionCalculationModePaced animations:^{
        self.transform = CGAffineTransformScale(self.transform, 0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
