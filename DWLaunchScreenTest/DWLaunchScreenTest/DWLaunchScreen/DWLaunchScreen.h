//
//  DWLaunchScreen.h
//  DWLaunchScreenTest
//
//  Created by dwang_sui on 2016/11/14.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import <UIKit/UIKit.h>

//skip显示位置
typedef enum : NSUInteger {
    TopRight,
    TopLeft,
    BottonLeft,
    BottonRight
} SkipLocation;

@protocol DWLaunchScreenDelegate <NSObject>

@optional
- (void)dw_didSelectImageView;

@end

@interface DWLaunchScreen : UIView

/************************************SKIP按钮*******************************/
/** skip按钮/建议不修改 */
@property (weak, nonatomic)     UIButton          *skip;

/** 是否显示skip/默认显示 */
@property (assign, nonatomic)   BOOL               skipHide;

/** skip背景颜色 */
@property (strong, nonatomic)   UIColor           *skipBgColor;

/** skip字体颜色 */
@property (strong, nonatomic)   UIColor           *skipTitleColor;

/** skip显示文字 */
@property (copy, nonatomic)     NSString          *skipString;

/** 字体大小/默认14 */
@property (assign, nonatomic)   NSInteger          skipFont;

/** 是否对skip切圆/默认YES */
@property (assign, nonatomic)   BOOL               skipBounds;

/** skip圆角尺寸/默认宽度的1/6 */
@property (assign, nonatomic)   NSInteger          skipRadius;

/** skip显示位置/默认右上方 */
@property (assign, nonatomic)   SkipLocation       skipLocation;


/***********************************logo图片**********************************/
/** logo图片 */
@property (strong, nonatomic)   UIImage           *logoImage;


/***********************************视图背景**********************************/
/** 背景颜色/默认无背景色 */
@property (strong, nonatomic)   UIColor           *bgColor;


/***********************************设置数据**********************************/
/** 显示时长/默认1.25f */
@property (assign, nonatomic)   NSInteger          accordingLength;

/** 消失动画时长/默认1.25 */
@property (assign, nonatomic)   NSTimeInterval     deleteLength;

/***********************************delegate**********************************/
/** 点击图片 */
@property (assign, nonatomic) id<DWLaunchScreenDelegate>delegate;

/**
 设置启动页数据

 @param content URL/UIImage/NSString
 @param window 主window
 @param error 错误信息
 @return 当前视图
 */
- (instancetype)dw_LaunchScreenContent:(id)content window:(UIWindow *)window withError:(void(^)(NSError *error))error;



@end
