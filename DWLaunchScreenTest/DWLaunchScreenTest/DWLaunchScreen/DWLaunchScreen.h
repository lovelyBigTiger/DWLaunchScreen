//
//  DWLaunchScreen.h
//  DWLaunchScreenTest
//
//  Created by dwang_sui on 2016/11/14.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWLaunchScreen : UIView

/** 背景颜色/默认白色 */
@property (strong, nonatomic) UIColor           *bgColor;

/** 显示时长/默认1.25f */
@property (assign, nonatomic) NSTimeInterval     accordingLength;

/** 消失时长/默认1.25 */
@property (assign, nonatomic) NSTimeInterval     deleteLength;

- (instancetype)dw_LaunchScreenImage:(UIImage *)image withWindow:(UIWindow *)window;

@end
