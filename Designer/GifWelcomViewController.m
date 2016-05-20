//
//  GifWelcomViewController.m
//  Designer
//
//  Created by Sincere on 16/5/12.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "GifWelcomViewController.h"
#import "MainViewController.h"

#import <UIImageView+PlayGIF.h>
#import <YFGIFImageView.h>

@interface GifWelcomViewController ()

@property (nonatomic,strong) YFGIFImageView * gifImageView;

@end

@implementation GifWelcomViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_gifImageView stopGIF];
    [_gifImageView removeFromSuperview];
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

    [self addGIF];
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
    MainViewController * main = [[MainViewController alloc] init];
    [self.navigationController pushViewController:main animated:YES];
}

@end
