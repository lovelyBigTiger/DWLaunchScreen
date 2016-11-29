//
//  DWLaunchScreen.m
//  DWLaunchScreenTest
//
//  Created by dwang_sui on 2016/11/14.
//  Copyright © 2016年 dwang. All rights reserved.
/*****************************Github:https://github.com/dwanghello/DWLaunchScreenTest********************/
/*****************************邮箱:dwang.hello@outlook.com***********************************************/
/*****************************QQ:739814184**************************************************************/
/*****************************QQ交流群:577506623*********************************************************/
/*****************************codedata官方群:157937068***************************************************/


#import "DWLaunchScreen.h"
#import "UIView+Extension.h"
#import "UIImageView+GIFExtension.h"

@interface DWLaunchScreen ()<UIWebViewDelegate>

/** imageView */
@property (weak, nonatomic) UIImageView *imageView;

/** WebView */
@property (weak, nonatomic) UIWebView *webView;

/** 计时器 */
@property (weak, nonatomic) NSTimer *timer;

/** string */
@property (copy, nonatomic) NSString *string;

/** count */
@property (assign, nonatomic) NSInteger count;

@end

@implementation DWLaunchScreen

#pragma mark ---初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.skipBounds = YES;
        
        self.count = 1;
        
    }
    return self;
}

#pragma mark ---设置数据
- (instancetype)dw_LaunchScreenContent:(id)content window:(UIWindow *)window withError:(void(^)(NSError *error))error {
    
    self.backgroundColor = [UIColor clearColor];
    
    self.frame = window.frame;
    
    UIButton *skip = [[UIButton alloc] init];
    
    self.skip = skip;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.05f target:self selector:@selector(setSkipTitle) userInfo:nil repeats:YES];
    
    [self.timer setFireDate:[NSDate distantFuture]];
    
    if ([content isKindOfClass:[UIImage class]]) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
        
        imageView.userInteractionEnabled = YES;
        
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
        
        self.skip.hidden = NO;
        
        self.imageView = imageView;
        
        imageView.image = content;
        
        [self addSubview:imageView];
        
        [self.timer setFireDate:[NSDate distantPast]];
        
    }
    
    if ([content isKindOfClass:[NSURL class]]) {
        
        if (!self.logoImage) {
     
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
            
            error(@"未设置logo默认图--->logoImage");
            
#pragma clang diagnostic pop
            
            
        }
        
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.frame];
        
        [webView.request setValue:@"2" forKey:@"_timeoutInterval"];
        
        webView.delegate = self;
        
        self.webView = webView;
        
        NSURL *url = content;
        
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
        
        self.string = url.absoluteString;
        
        [self addSubview:webView];
        
        self.skip.hidden = YES;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
        
        self.imageView = imageView;
        
        imageView.image = self.logoImage;
        
        [self addSubview:imageView];
        
    }
    
    if ([content isKindOfClass:[NSString class]]) {
        
        if (!self.logoImage) {
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
            
            error(@"未设置logo默认图--->logoImage");
            
#pragma clang diagnostic pop
            
        }
        
        NSString *string = content;
        
        if ([string hasPrefix:@"http"]) {
            
            UIWebView *webView = [[UIWebView alloc] initWithFrame:self.frame];
            
            webView.scalesPageToFit = YES;
            
            webView.scrollView.scrollEnabled = NO;
            
            webView.delegate = self;
            
            self.string = string;
            
            self.webView = webView;
            
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
            
            [self addSubview:webView];
            
            self.skip.hidden = YES;
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
            
            self.imageView = imageView;
            
            imageView.image = self.logoImage;
            
            [self addSubview:imageView];
            
        } else if ([string hasSuffix:@".gif"]) {
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
            
            self.imageView = imageView;
            
            imageView.userInteractionEnabled = YES;
            
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
            
            self.skip.hidden = NO;
            
            NSURL *imageURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:string ofType:nil]];
            
            [imageView dw_SetImage:imageURL];
            
            [imageView stopAnimating];
            
            imageView.image = [self snipGesturesPasswordsView:imageView rect:imageView.frame];
            
            [self addSubview:imageView];
            
            [self.timer setFireDate:[NSDate distantPast]];
            
            if (self.disappearType == DWCrosscutting) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
                error(@"GIF格式下暂时无法使用横切消失--->disappearType");
#pragma clang diagnostic pop
            }
            
        } else {
            
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            
            [self removeFromSuperview];
            
            return self;
        }
        
    }
    
    [window addSubview:self];
    [window bringSubviewToFront:self];
    
    if (!self.skipHide) {
        
        NSString *skipString = @"剩余:";
        if (self.skipString) {
            skipString = self.skipString;
        }
        [skip setTitle:[NSString stringWithFormat:@"   %@ %ld   ",skipString ,(long)self.accordingLength] forState:UIControlStateNormal];
        
        UIColor *skipTitleColor = [UIColor whiteColor];
        if (self.skipTitleColor) {
            skipTitleColor = self.skipTitleColor;
        }
        [skip setTitleColor:skipTitleColor forState:UIControlStateNormal];
        
        [skip addTarget:self action:@selector(skipSelf) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger font = 14;
        if (self.skipFont > 0) {
            font = self.skipFont;
        }
        [skip.titleLabel setFont:[UIFont systemFontOfSize:font]];
        
        UIColor *skipBgColor = [UIColor whiteColor];
        if (self.skipBgColor) {
            skipBgColor = self.skipBgColor;
        }
        skip.backgroundColor = skipBgColor;
        
        [skip sizeToFit];
        
        switch (self.skipLocation) {
            case 0:
                skip.x = self.width - skip.width - 10;
                skip.y = 25;
                break;
            case 1:
                skip.x = 10;
                skip.y = 25;
                break;
            case 2:
                skip.x = 10;
                skip.y = self.height - skip.height - 15;
                break;
            case 3:
                skip.x = self.width - skip.width - 10;
                skip.y = self.height - skip.height - 15;
                break;
            default:
                break;
        }
        
        [self addSubview:skip];
        
        if (self.skipBounds) {
            NSInteger skipRadius = skip.width/6;
            if (self.skipRadius > 0) {
                skipRadius = self.skipRadius;
            }
            skip.layer.cornerRadius = skipRadius;
            skip.clipsToBounds = YES;
        }
        
    }
    
    NSTimeInterval accordingLength = 3.0f;
    if (self.accordingLength > 0) {
        accordingLength = self.accordingLength;
    }
    
    return self;
}



#pragma mark ---修改按钮文字
- (void)setSkipTitle {
    
    NSInteger count = self.accordingLength --;
    
    if (count == 0) {
        
        [self performSelector:@selector(skipSelf) withObject:self afterDelay:0.5];
        
    }else {
        
        NSString *skipString = @"剩余:";
        if (self.skipString) {
            skipString = self.skipString;
        }
        [self.skip setTitle:[NSString stringWithFormat:@"   %@ %ld   ", skipString ,count] forState:UIControlStateNormal];
        [self.skip sizeToFit];
    }
    
}

#pragma mark ---跳过当前视图
- (void)skipSelf {
    
    [self.timer setFireDate:[NSDate distantFuture]];
    
    [self.timer invalidate];
    
    self.skip.hidden = YES;

    NSTimeInterval deleteLength = 0.5f;
    if (self.deleteLength) {
        deleteLength = self.deleteLength;
    }
    
    [UIView animateWithDuration:deleteLength animations:^{
        
        switch (self.disappearType) {
                
            case 1:{
                double proportion = 2.25f;
                if (self.proportion) {
                    proportion = self.proportion;
                }
                self.imageView.transform = CGAffineTransformScale(self.imageView.transform, proportion, proportion);
                self.webView.transform = CGAffineTransformScale(self.webView.transform, proportion, proportion);
            }break;
                
            case 2:{
                double proportion = 0.1f;
                if (self.proportion) {
                    proportion = self.proportion;
                }
                self.imageView.transform = CGAffineTransformScale(self.imageView.transform, proportion, proportion);
                self.webView.transform = CGAffineTransformScale(self.webView.transform, proportion, proportion);
            }break;
                
            case 3:{
                
                /** WebView */
                UIImageView *webTopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height*0.5)];
                
                webTopImageView.image = [self snipGesturesPasswordsView:self.webView rect:CGRectMake(0, 0, self.webView.width, self.webView.height * 0.5)];
                
                UIImageView *webBottonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height*0.5, self.width, self.height*0.5)];;
                
                webBottonImageView.image = [self snipGesturesPasswordsView:self.webView rect:CGRectMake(0, self.height*0.5, self.webView.width, self.height*0.5)];
                
                [self addSubview:webTopImageView];
                
                [self addSubview:webBottonImageView];
                
                webTopImageView.y = -self.webView.height * 0.5;
                
                webBottonImageView.y = self.webView.height;
                
                /** ImageView */
                UIImageView *imgTopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height*0.5)];
                
                imgTopImageView.image = [self snipGesturesPasswordsView:self.imageView rect:CGRectMake(0, 0, self.imageView.width, self.imageView.height * 0.5)];
                
                UIImageView *imgBottonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height*0.5, self.width, self.height * 0.5)];;
                
                imgBottonImageView.image = [self snipGesturesPasswordsView:self.imageView rect:CGRectMake(0, self.height*0.5, self.imageView.width, self.imageView.height * 0.5)];
                
                [self.imageView removeFromSuperview];
                
                [self.webView removeFromSuperview];
                
                [self addSubview:imgTopImageView];
                
                [self addSubview:imgBottonImageView];
                
                imgTopImageView.y = -self.imageView.height * 0.5;
                
                imgBottonImageView.y = self.imageView.height;
                
            }
                break;
            default:
                break;
        }
        
        self.skip.alpha = 0.0;
        
        self.imageView.alpha = 0.0;
        
        self.webView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self.imageView removeFromSuperview];
        
        [self.webView removeFromSuperview];
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
        [self removeFromSuperview];
        
    }];
    
}

#pragma mark ---图片点击
- (void)imageClick {
    
    if ([self.delegate respondsToSelector:@selector(dw_didSelectImageView)]) {
        
        [self.delegate dw_didSelectImageView];
        
    }
    
}

#pragma mark ---webViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
   
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self removeFromSuperview];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.imageView removeFromSuperview];
    
    if ([webView.request.URL.absoluteString isEqualToString:[NSString stringWithFormat:@"%@/", self.string]]) {
        
        [self.timer setFireDate:[NSDate distantPast]];
        
        self.skip.hidden = NO;
        
    }
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    
    if ([request.URL.absoluteString isEqualToString:[NSString stringWithFormat:@"%@/", self.string]]) {
        
        self.count ++;
        
        if (self.count == 3) {
            
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            
            [self removeFromSuperview];
            
        }
    }else {
        
        [self.timer setFireDate:[NSDate distantFuture]];
        
        self.skip.hidden = YES;
        
    }
    
    return YES;
    
}

#pragma mark ---
- (UIImage *)snipGesturesPasswordsView:(UIView *)view rect:(CGRect)rect {
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
        
        UIGraphicsBeginImageContextWithOptions(view.size, NO, [UIScreen mainScreen].scale);
        
    } else {
        
        UIGraphicsBeginImageContext(view.bounds.size);
        
    }
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return [self imageFromImage:image inRect:rect];
    
}

- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x= rect.origin.x*scale,y=rect.origin.y*scale,w=rect.size.width*scale,h=rect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
}

- (void)dealloc {
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
}

@end
