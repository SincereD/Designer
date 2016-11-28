//
//  DSBreakIntoViewController.m
//  Designer
//
//  Created by Sincere on 16/11/1.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "DSBreakIntoViewController.h"

#import "MainViewController.h"

@interface DSBreakIntoViewController (){
    
    UIImageView * _wifiCarImageView;
    
}

@end

@implementation DSBreakIntoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear: animated];
    
    [self initWiFiCar];
    
    [self addBreakInLab];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)initWiFiCar{
    
    _wifiCarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2.0, kScreenWidth*190/252/2.0)];
    [_wifiCarImageView setImage:[UIImage imageNamed:@"Wi-Fi车.png"]];
    [_wifiCarImageView setCenter:self.view.center];
    [_wifiCarImageView setUserInteractionEnabled:YES];
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
    animationPosition.duration = 1;
    animationPosition.fromValue = [NSValue valueWithCGPoint:self.view.center];
    animationPosition.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y + 20)];
    animationPosition.repeatCount = MAXFLOAT;
    animationPosition.autoreverses = YES;
    
    [_wifiCarImageView.layer addAnimation:animationScaleX forKey:nil];
    [_wifiCarImageView.layer addAnimation:animationPosition forKey:nil];
    [_wifiCarImageView.layer addAnimation:animationScaleY forKey:nil];
    
    [_wifiCarImageView startAnimating];
    
    UILongPressGestureRecognizer * press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    
    [press setMinimumPressDuration:2];
    
    [_wifiCarImageView addGestureRecognizer:press];
}


- (void)longPressAction:(UILongPressGestureRecognizer*)handelPress{
    
    if (handelPress.state == UIGestureRecognizerStateBegan) {
     
        [self.view setUserInteractionEnabled:NO];
        
        MainViewController * main = [[MainViewController alloc] init];
        
        [self.navigationController pushViewController:main animated:YES];
        
    }
}

- (void)addBreakInLab{
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(_wifiCarImageView.frame), kScreenWidth - 60, kScreenHeight - CGRectGetMaxY(_wifiCarImageView.frame))];
    
    [label setText:@"请确保在WiFi状态下打开，否则将使用到您宝贵的流量。土豪不在意这点小钱可长按摆渡车进入。"];
    
    [label setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:20.0f]];
    
    [label setNumberOfLines:0];
    
    [self.view addSubview:label];
    
}


@end
