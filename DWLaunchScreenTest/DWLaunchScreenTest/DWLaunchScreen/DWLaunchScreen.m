//
//  DWLaunchScreen.m
//  DWLaunchScreenTest
//
//  Created by dwang_sui on 2016/11/14.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWLaunchScreen.h"

@interface DWLaunchScreen ()

/** imageView */
@property (weak, nonatomic) UIImageView *imageView;

@end

@implementation DWLaunchScreen

- (instancetype)dw_LaunchScreenImage:(UIImage *)image withWindow:(UIWindow *)window {
    
    self.backgroundColor = [UIColor whiteColor];
    if (self.bgColor) {
        self.backgroundColor = self.bgColor;
    }
    
    self.frame = window.frame;
    
    [window addSubview:self];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
    
    self.imageView = imageView;
    
    imageView.image = image;
    
    [self addSubview:imageView];
    
    [self.window bringSubviewToFront:self];
    
    NSTimeInterval accordingLength = 1.25f;
    if (self.accordingLength > 0) {
        accordingLength = self.accordingLength;
    }
    
    [self performSelector:@selector(removeSelf) withObject:self afterDelay:accordingLength];
    
    return self;
}

- (void)removeSelf {
    
    NSTimeInterval deleteLength = 1.25f;
    if (self.deleteLength > 0) {
        deleteLength = self.deleteLength;
    }
    
    [UIView animateWithDuration:deleteLength animations:^{
        
        self.imageView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}

@end
