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

#import <UMSocialCore/UMSocialCore.h>

@interface DesignerView ()

@property (nonatomic,assign)BOOL isShaking;

@property (nonatomic,strong)YLGIFImage * gifImage;
@property (nonatomic,strong)YLImageView * gifImageView;

@property (nonatomic,strong)UIImage * normalImage;
@property (nonatomic,strong)UILabel * coprightLab;
@property (nonatomic,strong)UILabel * nameLab;
@property (nonatomic,strong)UIView * designerInfoView;
@property (nonatomic,strong)UIButton * shareBtn;

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

- (void)initDesignerInfoView
{
    if (!_designerInfoView)
    {
        _designerInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenWidth * GIFScale, kScreenWidth, kScreenWidth * GIFScale/4)];
        
        UIColor * color = [UIColor colorWithRed:arc4random_uniform(255)/265.0 green:arc4random_uniform(255)/265.0 blue:arc4random_uniform(255)/265.0 alpha:1];
        [_designerInfoView setBackgroundColor:color];

        UILabel * userRightLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        [userRightLab setText:_data.designerName];
        [userRightLab setTextColor:[UIColor whiteColor]];
        [_designerInfoView addSubview:userRightLab];
    }
    
    if (!_shareBtn)
    {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setFrame:CGRectMake(kScreenWidth - 60, kScreenWidth * GIFScale - 20, 40, 40)];
        [_shareBtn setImage:[UIImage imageNamed:@"分享图标.png"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"关闭分享.png"] forState:UIControlStateSelected];
        [_shareBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [_shareBtn.layer setCornerRadius:20.0f];
        [_shareBtn.layer setMasksToBounds:YES];
        [_shareBtn setBackgroundColor:[UIColor orangeColor]];
        [_shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self addSubview:_designerInfoView];
    [self addSubview:_shareBtn];
}

- (void)shareAction:(UIButton*)sender
{
    sender.selected = !sender.selected;
    
    [UIView animateWithDuration:0.8f animations:^{
        sender.transform = CGAffineTransformRotate(sender.transform, M_PI);
    } completion:^(BOOL finished) {
        NSLog(@"%@",self.data.serverURL);
        
        UMShareEmotionObject * obj = [UMShareEmotionObject shareObjectWithTitle:@"哈哈" descr:@"哈哈" thumImage:_normalImage];
        [obj setEmotionData:[NSData dataWithContentsOfURL:_data.fileURL]];
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObjectWithMediaObject:obj];
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self.keyVC completion:^(id data, NSError *error) {
            
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                NSLog(@"response data is %@",data);
            }
        }];
        
    }];
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
    [self showDesignerInfo];
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
    
    [_shareBtn removeFromSuperview];
    [_designerInfoView removeFromSuperview];
    [self hideDesignerInfo];
}

- (void)showDesignerInfo
{
    [UIView animateWithDuration:0.5f animations:^{
        _coprightLab.alpha = 0.0f;
        _nameLab.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self initDesignerInfoView];
    }];
}

- (void)hideDesignerInfo
{
    [UIView animateWithDuration:0.5f animations:^{
        _coprightLab.alpha = 1.0f;
        _nameLab.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)bring
{
    [self bringSubviewToFront:_nameLab];
    [self bringSubviewToFront:_coprightLab];
}

@end
