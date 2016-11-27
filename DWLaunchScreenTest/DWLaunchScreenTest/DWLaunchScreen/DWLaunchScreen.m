//
//  DWLaunchScreen.m
//  DWLaunchScreenTest
//
//  Created by dwang_sui on 2016/11/14.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWLaunchScreen.h"
#import "UIView+Extension.h"

@interface DWLaunchScreen ()<UIWebViewDelegate>

/** imageView */
@property (weak, nonatomic) UIImageView *imageView;

/** WebView */
@property (weak, nonatomic) UIWebView *webView;

/** 计时器 */
@property (weak, nonatomic) NSTimer *timer;

/** window */
@property (weak, nonatomic) UIWindow *window;

/** string */
@property (copy, nonatomic) NSString *string;

/** count */
@property (assign, nonatomic) NSInteger count;

@end

@implementation DWLaunchScreen

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.skipBounds = YES;
        
        self.count = 1;
        
    }
    return self;
}

- (instancetype)dw_LaunchScreenContent:(id)content window:(UIWindow *)window withError:(void(^)(NSError *error))error {
    
    self.backgroundColor = [UIColor clearColor];
    if (self.bgColor) {
        self.backgroundColor = self.bgColor;
    }
    
    self.frame = window.frame;
    
    self.window = window;
    
    UIButton *skip = [[UIButton alloc] init];
    
    self.skip = skip;
    
    if ([content isKindOfClass:[UIImage class]]) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
        
        imageView.userInteractionEnabled = YES;
        
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
        
        self.skip.hidden = NO;
        
        self.imageView = imageView;
        
        imageView.image = content;
        
        [self addSubview:imageView];
        
    }
    
    if ([content isKindOfClass:[NSURL class]]) {
        
        if (!self.logoImage) {
     
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
            
            error(@"未设置logo默认图--->logoImage");
            
#pragma clang diagnostic pop
            
            
        }
        
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.frame];
        
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
        
        NSString *urlString = content;
        
        if ([urlString hasPrefix:@"http"]) {
            
            UIWebView *webView = [[UIWebView alloc] initWithFrame:self.frame];
            
            webView.scalesPageToFit = YES;
            
            webView.scrollView.scrollEnabled = NO;
            
            webView.delegate = self;
            
            self.string = urlString;
            
            self.webView = webView;
            
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
            
            [self addSubview:webView];
            
            self.skip.hidden = YES;
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
            
            self.imageView = imageView;
            
            imageView.image = self.logoImage;
            
            [self addSubview:imageView];
            
        }else {
            
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
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(setSkipTitle) userInfo:nil repeats:YES];
    
    NSTimeInterval accordingLength = 3.0f;
    if (self.accordingLength > 0) {
        accordingLength = self.accordingLength;
    }
    
    return self;
}



#pragma mark ---修改按钮文字
- (void)setSkipTitle {
    
    NSInteger count = self.accordingLength --;
    
    if (count < 0) {
        
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

    NSTimeInterval deleteLength = 0.58f;
    if (self.deleteLength) {
        deleteLength = self.deleteLength;
    }
    
    [UIView animateWithDuration:deleteLength animations:^{
        
        self.skip.alpha = 0.0;
        
        self.imageView.alpha = 0.0;
        
        self.webView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self.imageView removeFromSuperview];
        
        [self.webView removeFromSuperview];
        
        [self removeFromSuperview];
        
    }];
    
}

- (void)imageClick {
    
    if ([self.delegate respondsToSelector:@selector(dw_didSelectImageView)]) {
        
        [self.delegate dw_didSelectImageView];
        
    }
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
   
    [self removeFromSuperview];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.imageView removeFromSuperview];
    
    if ([webView.request.URL.absoluteString hasPrefix:self.string]) {
        
        [self.timer setFireDate:[NSDate distantPast]];
        
        self.skip.hidden = NO;
        
    }else {
        
        [self.timer setFireDate:[NSDate distantFuture]];
        
        self.skip.hidden = YES;
        
    }
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([request.URL.absoluteString hasPrefix:self.string]) {
        
        self.count ++;
        
        if (self.count == 3) {
            
            [self removeFromSuperview];
            
        }
    }
    
    return YES;
    
}

@end
