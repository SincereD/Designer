//
//  DSBreakIntoViewController.m
//  Designer
//
//  Created by Sincere on 16/11/1.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "DSBreakIntoViewController.h"

@interface DSBreakIntoViewController (){
    
    UIImageView * _wifiCarImageView;
    
}

@end

@implementation DSBreakIntoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear: animated];
    
    [self initWiFiCar];
}

- (void)initWiFiCar{
    
    _wifiCarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*190/252)];
    [_wifiCarImageView setImage:[UIImage imageNamed:@"Wi-Fi车.png"]];
    [_wifiCarImageView setCenter:self.view.center];
    [self.view addSubview:_wifiCarImageView];
    
    CABasicAnimation * animationScaleX = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    animationScaleX.duration = 0.5;
    animationScaleX.repeatCount = MAXFLOAT;
    animationScaleX.fromValue = @1.0;
    animationScaleX.toValue = @1.2;
    animationScaleX.autoreverses = YES;
    
    CABasicAnimation * animationScaleY = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    animationScaleY.duration = 0.5;
    animationScaleY.repeatCount = MAXFLOAT;
    animationScaleY.fromValue = @1.0;
    animationScaleY.toValue = @1.1;
    animationScaleY.autoreverses = YES;
    
    CABasicAnimation * animationPosition = [CABasicAnimation animationWithKeyPath:@"position"];
    animationPosition.duration = 0.5;
    animationPosition.fromValue = [NSValue valueWithCGPoint:self.view.center];
    animationPosition.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y + 20)];
    animationPosition.repeatCount = MAXFLOAT;
    animationPosition.autoreverses = YES;
    
//    CAAnimationGroup * group = [[CAAnimationGroup alloc] init];
//    [group setAnimations:@[animationScaleX,animationScaleY,animationPosition]];
//    [_wifiCarImageView.layer addAnimation:group forKey:@"HaHa"];
    
    [_wifiCarImageView.layer addAnimation:animationScaleX forKey:nil];
    [_wifiCarImageView.layer addAnimation:animationPosition forKey:nil];
    [_wifiCarImageView.layer addAnimation:animationScaleY forKey:nil];
    
    [_wifiCarImageView startAnimating];
}



@end
