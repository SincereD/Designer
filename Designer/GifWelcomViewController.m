//
//  GifWelcomViewController.m
//  Designer
//
//  Created by Sincere on 16/5/12.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "GifWelcomViewController.h"
#import "UIColor+DSHexColor.h"
#import "MainViewController.h"
#import "DSBreakIntoViewController.h"

#import <UIImageView+PlayGIF.h>
#import <YFGIFImageView.h>

#import <AFNetworkReachabilityManager.h>


@interface GifWelcomViewController ()
{
    NSInteger _index;
    
    NSInteger _count;
    
    NSInteger _animationCount;
    
    NSTimer * _timer;
}

@property (nonatomic,strong) YFGIFImageView * gifImageView;

@end

@implementation GifWelcomViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
//    [self startAniamtion];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self testColorView];
    
    [self startAniamtion];
}

- (void)testColorView{
    
    _index = -1;
    
    _count = 0;
    
    _animationCount = 0;
    
    CGFloat a = [UIScreen mainScreen].bounds.size.height;
    CGFloat c = [UIScreen mainScreen].bounds.size.width;
    CGFloat b = sqrtf(a*a + c*c);
    CGFloat y = b/24.0f;
    
    CGFloat cosC = (a*a + b*b - c*c)/(2*a*b);
    
    CGFloat x1 = 2 * cosC * y + sqrtf(2*cosC*y * 2*cosC*y - 2*y*y);
    CGFloat x2 = 2 * cosC * y - sqrtf(pow(2*cosC*y, 2) - 2*y*y);
    
    NSLog(@"x1:%f",x1);
    NSLog(@"x2:%f",x2);
    
    NSArray * colorArray = @[@"f9c53d",@"f9a932",@"f98020",@"f95b1b",@"f9431b",@"d4443e",
                             @"96557d",@"6767ad",@"4777ce",@"3792dd",@"3ba9d2",@"4ec0b9"];
    
    for (int i = 0 ; i<12; i++) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(-[UIScreen mainScreen].bounds.size.width*0.5, (i-2)*x1, [UIScreen mainScreen].bounds.size.width*2, x1/sqrtf(2))];
        
        UIColor * color = [self colorWithHexString:colorArray[i]];
        
        [view setBackgroundColor:color];
        
        view.transform = CGAffineTransformRotate(view.transform, -M_PI_4);
        
        [view setTag:i+1000];
        
        [self.view addSubview:view];
    }
    
}

- (void)startAniamtion{
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(animationing) userInfo:nil repeats:YES];
    
    [_timer fire];
}

- (void)animationing{
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height/12.0f;
    
    if (_index<12) {
        
        UIView * view = [self.view viewWithTag:_index+1000];
        
        [UIView animateWithDuration:0.9 animations:^{
            [view setAlpha:_count];
        }];
        
    }else{
        
        if (_count == 0) {
            
            _count ++;
            _index = -1;
            
        }else{
            [_timer invalidate];
            
            _timer = nil;
            
            for (int i = 0 ; i<12; i++) {
                UIView * view = [self.view viewWithTag:i+1000];
                
                [UIView animateWithDuration:0.5 animations:^{
                    view.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.5 animations:^{
                        view.frame = CGRectMake(0, height*i, [UIScreen mainScreen].bounds.size.width, height);
                    } completion:^(BOOL finished) {
                        
                        [UIView animateWithDuration:0.5 animations:^{
                            view.transform = CGAffineTransformMakeTranslation(-[UIScreen mainScreen].bounds.size.width, 0);
                        } completion:^(BOOL finished) {
                            
                            _animationCount ++;
                            if (_animationCount>=12) {
                                [self pushToMain];
                            }
                        }];
                        
                    }];
                }];
            }
        }
    }
    
    _index ++ ;
}

- (void)addGIF
{
    UIImageView * welcomeGIF = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    welcomeGIF.center = self.view.center;
    [welcomeGIF setGifPath:[[NSBundle mainBundle] pathForResource:@"LaunchGif" ofType:@"gif"]];
    [welcomeGIF startGIF];
    [welcomeGIF setUserInteractionEnabled:YES];
    [self.view addSubview:welcomeGIF];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToMain)];
    [welcomeGIF addGestureRecognizer:tap];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(14.50f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [welcomeGIF stopGIF];
    });
}

- (void)pushToMain
{
    
//    DSBreakIntoViewController * breakVC = [[DSBreakIntoViewController alloc] init];
//    [self.navigationController pushViewController:breakVC animated:NO];
//    
//    return;
    
    if (![AFNetworkReachabilityManager sharedManager].isReachableViaWiFi) {
        MainViewController * main = [[MainViewController alloc] init];
       
        [self.navigationController pushViewController:main animated:NO];
        
    }else{
        
        DSBreakIntoViewController * breakVC = [[DSBreakIntoViewController alloc] init];
        [self.navigationController pushViewController:breakVC animated:NO];
    }
    
}

- (UIColor*)colorWithHexString:(NSString*)hexString{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexString substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexString substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexString substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}

@end
