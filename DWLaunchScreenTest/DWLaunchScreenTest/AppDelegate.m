//
//  AppDelegate.m
//  DWLaunchScreenTest
//
//  Created by dwang_sui on 2016/11/14.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DWLaunchScreen.h"

@interface AppDelegate ()<DWLaunchScreenDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[ViewController alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    [NSThread sleepForTimeInterval:1.25f];
    
    DWLaunchScreen *launch = [[DWLaunchScreen alloc] init];
    
    launch.delegate = self;
    
    launch.accordingLength = 5;
    
//    launch.bgColor = [UIColor whiteColor];
    
//    launch.deleteLength = 3.0f;
    
//    launch.skipHide = YES;
    
    launch.skipString = @"等待:";
    
    launch.skipTitleColor = [UIColor blackColor];
    
    launch.skipBgColor = [UIColor orangeColor];
    
//    launch.skipLocation = top;
    
//    launch.skipFont = 18;
    
    launch.logoImage = [UIImage imageNamed:@"bg.jpg"];
    
//    [launch dw_LaunchScreenContent:@"https://www.baidu.com" window:self.window withError:^(NSError *error) {
//        
//         NSLog(@"error:%@", error);
//        
//    }];
    
//    [launch dw_LaunchScreenContent:[UIImage imageNamed:@"bg.jpg"] window:self.window withError:^(NSError *error) {
//        
//        NSLog(@"error:%@", error);
//        
//    }];

    [launch dw_LaunchScreenContent:[NSURL URLWithString:@"https://www.baidu.com"] window:self.window withError:^(NSError *error) {
        
        NSLog(@"error:%@", error);
        
    }];
    
    return YES;
}

- (void)dw_didSelectImageView {
    
    NSLog(@"点击了图片");
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end