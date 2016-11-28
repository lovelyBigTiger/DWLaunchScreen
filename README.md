# 自定义启动页/广告页
---
# 如果感觉不错，请给个Star支持一下
# 使用中如果遇到什么问题可以联系我
# QQ:739814184 
# 微信:ai739814184
# QQ群:577506623
# e-mail:dwang.hello@outlook.com
# 简书:
---
![默认](http://g.hiphotos.baidu.com/image/pic/item/e824b899a9014c08409ffa89037b02087bf4f472.jpg)

---
![放大](http://d.hiphotos.baidu.com/image/w%3D310/sign=52e830366959252da3171b05049b032c/a2cc7cd98d1001e9b210c623b10e7bec54e797ea.jpg)

---
![缩小](http://b.hiphotos.baidu.com/image/w%3D310/sign=b80cdf1d283fb80e0cd167d606d02ffb/d009b3de9c82d158755a8a9d890a19d8bd3e42c6.jpg)

---
![横切](http://f.hiphotos.baidu.com/image/w%3D310/sign=625d14c2bd8f8c54e3d3c32e0a292dee/a686c9177f3e6709043197d332c79f3df8dc55ed.jpg)

---
#### 将Demo中的DWLaunchScreen文件夹拖入到您的工程中

---
#### 在AppDelegate.m中引入头文件
    #import "DWLaunchScreen.h"
    
#### 如果为Image对象并且需要点击则需要设置代理
    <DWLaunchScreenDelegate>

    
---
####在- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions方法中加入以下代码
self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[ViewController alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    //    [NSThread sleepForTimeInterval:1.25f];
    
    DWLaunchScreen *launch = [[DWLaunchScreen alloc] init];
    
    //设置代理，只有图片格式需要点击时才需设置
    launch.delegate = self;
    
    //设置显示时长
    launch.accordingLength = 3.0;
    
    //设置消失耗时
    launch.deleteLength = 3.0f;
    
    //消失方式
    launch.disappearType = DWCrosscutting;
    
    //是否隐藏按钮
    //    launch.skipHide = YES;
    
    //按钮显示文字
    launch.skipString = @"等待:";
    
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
    
    //    NSURL格式
    [launch dw_LaunchScreenContent:[NSURL URLWithString:@"https://www.baidu.com"] window:self.window withError:^(NSError *error) {
        
        NSLog(@"error:%@", error);
    
    }];
    
    return YES;

---
# #pragma mark ---点击了图片，只有图片格式时才生效
     - (void)dw_didSelectImageView {
    
    NSLog(@"点击了图片");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"点击了图片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    }

---
# 使用中如果遇到问题可以Issues我




