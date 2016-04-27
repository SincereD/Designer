//
//  MainViewController.m
//  Designer
//
//  Created by Sincere on 16/4/27.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "MainViewController.h"
#import "InfoViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self leftItem];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)leftItem
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setFrame: CGRectMake(0, 0, 28, 28)];
    [rightBtn setBackgroundColor:[UIColor redColor]];
    [rightBtn addTarget:self action:@selector(rightItmeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightItme = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:rightItme];
}

- (void)rightItmeAction:(id)sender
{
    InfoViewController * infoVC = [[InfoViewController alloc] init];
    [self.navigationController pushViewController:infoVC animated:YES];
}

@end
