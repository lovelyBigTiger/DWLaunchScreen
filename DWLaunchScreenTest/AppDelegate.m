//
//  AppDelegate.m
//  DWLaunchScreenTest
//
//  Created by dwang_sui on 2016/11/14.
//  Copyright © 2016年 dwang. All rights reserved.
/*****************************Github:https://github.com/dwanghello/DWLaunchScreenTest********************/
/*****************************邮箱:dwang.hello@outlook.com***********************************************/
/*****************************QQ:739814184**************************************************************/
/*****************************QQ交流群:577506623*********************************************************/
/*****************************codedata官方群:157937068***************************************************/


#import "AppDelegate.h"
#import "ViewController.h"
#import "DWLaunchScreen.h"

@interface AppDelegate ()<DWLaunchScreenDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    //    [NSThread sleepForTimeInterval:1.25f];
    
    DWLaunchScreen *launch = [[DWLaunchScreen alloc] init];
    
    //设置代理，只有图片格式需要点击时才需设置
    launch.delegate = self;
    
    //设置显示时长
//    launch.accordingLength = 4.0;
    
    //设置消失耗时
    launch.deleteLength = 3.0f;
    
    launch.skipTimerHide = YES;
    
    //消失方式
    launch.disappearType = DWAmplification;
    
    //是否隐藏按钮
    //    launch.skipHide = YES;
    
    //按钮显示文字
//    launch.skipString = @"等待:";
    
    //字体颜色
    launch.skipTitleColor = [UIColor blackColor];
    
    //字体大小
    launch.skipFont = 18;
    
    //按钮背景颜色
    launch.skipBgColor = [UIColor orangeColor];
    
    //按钮显示位置
    launch.skipLocation = LeftTop;
    
    //网络时的渲染图，建议与启动图相同
    launch.logoImage = [UIImage imageNamed:@"bg.jpg"];
    
//    NSString格式
//        [launch dw_LaunchScreenContent:@"https://www.baidu.com" window:self.window withError:^(NSError *error) {
//    
//             NSLog(@"error:%@", error);
//    
//        }];
    
    
//    UIImage格式
//        [launch dw_LaunchScreenContent:[UIImage imageNamed:@"cat.jpeg"] window:self.window withError:^(NSError *error) {
//    
//            NSLog(@"error:%@", error);
//    
//        }];
//
//     GIF格式
//    [launch dw_LaunchScreenContent:@"fengjing.gif" window:self.window withError:^(NSError *error) {
//        
//        
//        NSLog(@"%@", error);
//        
//    }];
    
//    NSURL格式
    [launch dw_LaunchScreenContent:[NSURL URLWithString:@"https://www.baidu.com"] window:self.window withError:^(NSError *error) {
        
        NSLog(@"error:%@", error);
    
    }];
    
    return YES;
}

#pragma mark ---点击了图片，只有图片格式时才生效
- (void)dw_didSelectImageView {
    
    NSLog(@"点击了图片");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"点击了图片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
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
