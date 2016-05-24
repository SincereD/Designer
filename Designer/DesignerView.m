//
//  DesignerView.m
//  Designer
//
//  Created by Sincere on 16/5/20.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "DesignerView.h"
#import <YFGIFImageView.h>

#import <YLImageView.h>
#import <YLGIFImage.h>
#import <UIImageView+PlayGIF.h>

@interface DesignerView ()

@property (nonatomic,strong)YLGIFImage * gifImage;
@property (nonatomic,strong)UIImage * normalImage;
@property (nonatomic,assign)BOOL isShaking;
@property (nonatomic,strong)UILabel * coprightLab;
@property (nonatomic,strong)UILabel * nameLab;
@property (nonatomic,strong)YLImageView * gifImageView;

@end

@implementation DesignerView

- (instancetype)init
{
    if (self = [super init])
    {
        [self setFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*GIFScale)];
    }
    return self;
}

- (void)setData:(DesignerData *)data
{
    _data = data;
    [self initSences];
}

- (void)initSences
{
    _gifImage = (YLGIFImage*)[YLGIFImage imageWithData:_data.gifData ];
    _gifImageView = [[YLImageView alloc] init];
    [_gifImageView setFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*GIFScale)];
    [_gifImageView setBackgroundColor:[UIColor grayColor]];
    [_gifImageView setUserInteractionEnabled:YES];
    
    _normalImage= [_gifImage getFrameWithIndex:0];
    [_gifImageView setImage:_normalImage];
    [self addSubview:_gifImageView];
    [self sendSubviewToBack:_gifImageView];
    _isShaking = NO;
    _bgColor = [_normalImage mostColor];
}

- (void)exchangeShakeState
{
    if (_isShaking)
    {
        [self stopShaking];
    }
    else
    {
        [self startShaking];
    }
}

- (void)startShaking
{
    [_gifImageView setImage:_gifImage];
    _isShaking = YES;
    [self sendSubviewToBack:_gifImageView];
    [self bring];
}

- (void)stopShaking
{
    [_gifImageView removeFromSuperview];
    _gifImageView = nil;

    _gifImageView = [[YLImageView alloc] init];
    [_gifImageView setFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*GIFScale)];
    [_gifImageView setBackgroundColor:[UIColor grayColor]];
    [_gifImageView setUserInteractionEnabled:YES];
    
    _normalImage= [_gifImage getFrameWithIndex:0];
    [_gifImageView setImage:_normalImage];
    [self addSubview:_gifImageView];
    [self sendSubviewToBack:_gifImageView];
    _isShaking = NO;
}

- (void)wordsAnimation
{
    if (!_coprightLab)
    {
        UIColor * textColor;
        if ([_bgColor isDarkColor])
        {
            textColor = [UIColor whiteColor];
        }
        else
        {
            textColor = [UIColor blackColor];
        }
        _coprightLab = [[UILabel alloc] init];
        [_coprightLab setText:@"版权:"];
        [_coprightLab setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:16.0f]];
        [_coprightLab setTextColor:textColor];
        [_coprightLab setFrame:CGRectMake(0, self.frame.size.height-30, _coprightLab.text.length*16, 25)];
        [self addSubview:_coprightLab];
        
        _nameLab = [[UILabel alloc] init];
        [_nameLab setText:[NSString stringWithFormat:@"原作者:%@",_data.designerName]];
        [_nameLab setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:16.0f]];
        [_nameLab setTextColor:textColor];
        [_nameLab setFrame:CGRectMake(self.frame.size.width - 200, self.frame.size.height-30, _nameLab.text.length*16, 25)];
        [self addSubview:_nameLab];
    }
    [self bring];
    
    _coprightLab.alpha = 0.0f;
    _nameLab.alpha = 0.0f;
    [UIView animateWithDuration:0.5 animations:^{
        _coprightLab.alpha = 1.0f;
        _nameLab.alpha = 1.0f;
    }];
    
}

- (void)bring
{
    [self bringSubviewToFront:_nameLab];
    [self bringSubviewToFront:_coprightLab];
}

@end
