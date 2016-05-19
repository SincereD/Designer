//
//  MainViewController.m
//  Designer
//
//  Created by Sincere on 16/4/27.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "MainViewController.h"
#import "InfoViewController.h"
#import <UIImageView+PlayGIF.h>
#import <AFNetworking.h>

@interface MainViewController ()<UIGestureRecognizerDelegate>

@end

@implementation MainViewController

//eZDoLLLV
- (void)viewDidLoad
{
    [super viewDidLoad];
     self.title = @"动效王国";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Sources"];
    
    [bquery calcInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSLog(@"%@",array);
    }];
    
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:@"nxZp444E" block:^(BmobObject *object,NSError *error){
        if (error)
        {
            
        }else
        {
            if (object)
            {
                NSString * designerName = [object objectForKey:@"ImageUrl"];
                NSString * urlstr = [NSString stringWithFormat:@"http://7xtf1s.com1.z0.glb.clouddn.com/%@",designerName];
                [self downLoadWithURL:urlstr];
            }
        }
    }];

}

- (void)downLoadWithURL:(NSString*)url
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        NSData * data = [NSData dataWithContentsOfURL:filePath];
        UIImageView * imageView = [[UIImageView alloc] init];
        [imageView setFrame:self.view.bounds];
        [imageView setGifData:data];
        [imageView startGIF];
        [self.view addSubview:imageView];
        
    }];
    [downloadTask resume];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"DFWaWaSC-W5" size:25.0f]}];
    [self rightItem];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)rightItem
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setFrame: CGRectMake(0, 0, 32, 32)];
    [rightBtn addTarget:self action:@selector(rightItmeAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"关于@2x.jpg"] forState:UIControlStateNormal];
    [rightBtn setTintColor:[UIColor blackColor]];
    [rightBtn.titleLabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:25.0f]];
    UIBarButtonItem * rightItme = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self setBaseRightBarButtonItem:rightItme];
    
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    anima.values = @[@1,@1.2,@1];
    anima.duration = 2.0f;
    anima.repeatCount = MAXFLOAT;
    [rightBtn.layer addAnimation:anima forKey:@"scale"];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setFrame: CGRectMake(0, 0, 28, 28)];
    [leftBtn setUserInteractionEnabled:NO];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self setBaseLeftBarButtonItem:leftItem];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)rightItmeAction:(id)sender
{
    InfoViewController * infoVC = [[InfoViewController alloc] init];
    [self.navigationController pushViewController:infoVC animated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

@end
