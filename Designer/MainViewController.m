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

#import "LoadingView.h"
#import "DesignerData.h"
#import "DesignerTableViewCell.h"
#import "DesignerView.h"
#import "UIView+DSCapture.h"

@interface MainViewController ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView    * _table;

    NSMutableArray * _dataSource;
    NSMutableArray * _dataCellSource;

    LoadingView    * _loadingView;
    DesignerView   * _lastDesignerView;
    
    NSInteger        _lastSection;
    NSInteger        _currentSection;
}
@end

@implementation MainViewController

//eZDoLLLV
- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.title = @"一起摇摆";
    _currentSection = -1;
    _lastSection = -1;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _dataCellSource = [NSMutableArray arrayWithCapacity:0];
    
    _loadingView = [[LoadingView alloc] init];
    
    [_loadingView showOnView:self.view];
    
    BmobQuery * bquery = [BmobQuery queryWithClassName:@"Sources"];

    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsPath = [paths firstObject];
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    [bquery calcInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        _dataSource = [NSMutableArray arrayWithArray:array];
        
        [_dataSource sortWithKey:@"updatedAt" ascending:NO];
        
        for (NSDictionary * object in _dataSource)
        {
            NSString * designerName = [object objectForKey:@"ImageUrl"];
            NSString * filePath = [documentsPath stringByAppendingString:[NSString stringWithFormat:@"/%@",designerName]];

            NSURL* fileURL = [documentsDirectoryURL URLByAppendingPathComponent:designerName];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
            {
                [self initCellWithURL:fileURL];
            }
            else
            {
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
        
        if (!error)
        {
            [NSThread detachNewThreadSelector:@selector(initCellWithURL:) toTarget:self withObject:filePath];
        }
        
    }];
    [downloadTask resume];
}

- (void)initCellWithURL:(NSURL*)URL
{
    DesignerData * data = [[DesignerData alloc] initWithFileURL:URL];
    NSLog(@"%@",data.designerName);
    DesignerView * designerView = [[DesignerView alloc] init];
    [designerView setData:data];
    [_dataCellSource addObject:designerView];
    
    if (_dataCellSource.count == _dataSource.count)
    {
        [self performSelectorOnMainThread:@selector(initTable) withObject:nil waitUntilDone:YES];
    }
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
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame: CGRectMake(0, 0, 32, 32)];
    [rightBtn addTarget:self action:@selector(rightItmeAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [rightBtn setImage:[UIImage imageNamed:@"关于@2x.png"] forState:UIControlStateNormal];
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

- (void)initTable
{
    [_loadingView removeLoadingView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!_table)
        {
            _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64.0f) style:UITableViewStylePlain];
            [_table setDelegate:self];
            [_table setDataSource:self];
            [_table setSeparatorColor:[UIColor clearColor]];
            [_table setSectionIndexColor:[UIColor clearColor]];
            [_table setShowsVerticalScrollIndicator:NO];
            [_table setShowsHorizontalScrollIndicator:NO];
            [self.view addSubview:_table];
        }
    });
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (DesignerTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DesignerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DesignerTableViewCell"];
    if (!cell)
    {
        cell = [[DesignerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DesignerTableViewCell"];
    }else
    {
        for (UIView* view in [cell subviews])
        {
            [view removeFromSuperview];
        }
    }
    
    DesignerView * designerView = _dataCellSource[indexPath.section];
    [designerView setKeyVC:self];
    [cell setDesignerView:designerView];
    [cell setBackgroundColor:designerView.bgColor];
    [cell addSubview:designerView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenWidth * GIFScale;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DesignerTableViewCell *cardCell = (DesignerTableViewCell *)cell;
    [cardCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (_currentSection == indexPath.section)
    {
        [cardCell.designerView showDesignerInfo];
        return;
    }
    
    if (_lastSection == indexPath.section)
    {
        return;
    }
    
    static CGFloat initialDelay = 0.2f;
    static CGFloat stutter = 0.06f;
    
    [cardCell startAnimationWithDelay:initialDelay + ((indexPath.section) * stutter)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    DesignerView * design = (DesignerView*)_dataCellSource[indexPath.section];

    if (_currentSection == indexPath.section)
    {
        [design stopShaking];
        _currentSection = -1;
        _lastSection = -1;
        _lastDesignerView = nil;
        
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        [_table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        return;
    }
    
    _currentSection = indexPath.section;
    
    if (_lastSection != -1)
    {
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:_lastSection] withRowAnimation:UITableViewRowAnimationFade];
    }
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:_currentSection] withRowAnimation:UITableViewRowAnimationFade];
    
    if (!_lastDesignerView)
    {
        [design startShaking];
    }
    else
    {
        if (_lastDesignerView == design)
        {
            return;
        }
        [_lastDesignerView stopShaking];
        
        [design startShaking];
    }
    _lastDesignerView =  design;
    _lastSection = indexPath.section;

    [_table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end
