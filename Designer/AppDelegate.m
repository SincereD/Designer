//
//  AppDelegate.m
//  Designer
//
//  Created by Sincere on 16/4/19.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>
#import <UMSocialCore/UMSocialCore.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

#define BombAppKey @"6cd4eb4177a9c555fd390704c67e5e2d"
#define MobAppKey  @"571f6d0ce0f55a8343002562"
#define UMAppKey   @"583b9eb95312dd08c6000995"

//微信
//ID  wx2d31830279beb91d
//KEY 79546a6cc6c8ebc89ed4ef324af98451

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Bmob registerWithAppKey:BombAppKey];
    
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMAppKey];
    [[DSNetWork sharedNetWork] configureReachManager];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx2d31830279beb91d" appSecret:@"79546a6cc6c8ebc89ed4ef324af98451" redirectURL:@"http://mobile.umeng.com/social"];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
