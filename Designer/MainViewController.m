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

//eZDoLLLV
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Wisdom";

    
    NSLog(@"%p",[DSNetWork sharedNetWork]);
    NSLog(@"%p",[[DSNetWork sharedNetWork] copy]);
    NSLog(@"%p",[[DSNetWork sharedNetWork] mutableCopy]);
    
    [self.navigationController.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"Bradley Hand" size:15.0f]} forState:UIControlStateNormal];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"Bradley Hand" size:30.0f]}];
    
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Sources"];
    
    [bquery calcInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSLog(@"%@",array);
    }];
    
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:@"eZDoLLLV" block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
                //得到playerName和cheatMode
                NSString *playerName = [object objectForKey:@"ImageUrl"];
                NSLog(@"%@",playerName);
                playerName = [NSString stringWithFormat:@"http://7xtf1s.com1.z0.glb.clouddn.com/%@",playerName];
                
                UIImageView * ImageView = [[UIImageView alloc] init];
                [ImageView sd_setImageWithURL:[NSURL URLWithString:playerName]];
                [ImageView setFrame:self.view.bounds];
//                [self.view addSubview:ImageView];
                
            }
        }
    }];

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
    [self setBaseRightBarButtonItem:rightItme];

}

- (void)rightItmeAction:(id)sender
{
    InfoViewController * infoVC = [[InfoViewController alloc] init];
    [self.navigationController pushViewController:infoVC animated:YES];
}

@end
