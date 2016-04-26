//
//  ViewController.m
//  Designer
//
//  Created by Sincere on 16/4/19.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "ViewController.h"
#import <BmobSDK/Bmob.h>

@interface ViewController ()

@end

//7xtf1s.com1.z0.glb.clouddn.com
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"_User"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:@"5d2jgggq" block:^(BmobObject *object,NSError *error){
        if (error)
        {
            //进行错误处理
        }
        else
        {
            //表里有id为0c6db13c的数据
            if (object)
            {
                NSString *playerName = [object objectForKey:@"username"];
                NSLog(@"%@",playerName);
            }
        }
    }];
}


@end
