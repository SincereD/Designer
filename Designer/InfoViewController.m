//
//  InfoViewController.m
//  Designer
//
//  Created by Sincere on 16/4/27.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation InfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBackBtn];
    
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
    
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
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
    
}

- (void)copyright
{
    
}

- (void)designer
{
    
}

- (void)coder
{
    
}

@end
