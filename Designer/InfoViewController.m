//
//  InfoViewController.m
//  Designer
//
//  Created by Sincere on 16/4/27.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoData.h"
#import "InfoView.h"

@interface InfoViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
{
    CGFloat _height;
    InfoView * copyrightView;
    InfoView * designerView;
    InfoView * coderView;
}
@end

@implementation InfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBackBtn];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initSences];
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)initBackBtn
{
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"<关于";
    [returnButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"DFWaWaSC-W5" size:20.0f]} forState:UIControlStateNormal];
    [returnButtonItem setAction:@selector(popBack)];
    [returnButtonItem setTarget:self];
    [returnButtonItem setTintColor:[UIColor brownColor]];
    self.navigationItem.leftBarButtonItem = returnButtonItem;
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController   respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initSences
{
    _height = (kScreenHeight - 64.0f)/3.0f;
    [self.view setClipsToBounds:YES];
    if (!copyrightView)
    {
        [self copyright];
        [self coder];
        [self designer];
    }
}

- (void)copyright
{
    InfoData * copyrightData = [[InfoData alloc]initWithPhotoName:@"copyright.png" mailBox:nil subject:@"动效王国v1.0"];
    copyrightView = [[InfoView alloc] initWithData:copyrightData frame:CGRectMake(-kScreenWidth, 64, kScreenWidth, _height)];
    [self.view addSubview:copyrightView];
    
    [UIView animateWithDuration:0.8 animations:^{
        [copyrightView setFrame:CGRectMake(0, 64, kScreenWidth, _height)];
    }];
}

- (void)designer
{
    InfoData * designerData = [[InfoData alloc] initWithPhotoName:@"designer.png"
                                                           mailBox:@"yu.yi.fan@foxmail.com"
                                                           subject:@"抠图师"];
    designerView = [[InfoView alloc] initWithData:designerData
                                                       frame:CGRectMake(kScreenWidth, _height + 64, kScreenWidth, _height)];
    [self.view addSubview:designerView];
    [UIView animateWithDuration:0.8 animations:^{
        [designerView setFrame:CGRectMake(0, _height + 64, kScreenWidth, _height)];
    }];
}

- (void)coder
{
    InfoData * coderData = [[InfoData alloc] initWithPhotoName:@"coder"
                                                       mailBox:@"sincere129120@icloud.com"
                                                       subject:@"代码猴"];
    coderView = [[InfoView alloc] initWithData:coderData
                                                    frame:CGRectMake(-kScreenWidth, 64 + _height * 2.0f, kScreenWidth, _height)];
    [self.view addSubview:coderView];
    
    [UIView animateWithDuration:0.8 animations:^{
        [coderView setFrame:CGRectMake(0, _height*2 + 64, kScreenWidth, _height)];
    }];
}

@end
