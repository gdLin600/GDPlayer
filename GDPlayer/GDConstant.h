//
//  GDConstant.h
//  GDPlayerExample
//
//  Created by 林广德 on 16/5/23.
//  Copyright © 2016年 林广德. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,GDPlayerState) {
    GDPlayerStateBuffering = 1,
    GDPlayerStatePlaying   = 2,
    GDPlayerStateStopped   = 3,
    GDPlayerStatePause     = 4
};

typedef void(^PlayerProgress)(NSInteger duration);


/** playerHandleView 中控件的左间距*/
UIKIT_EXTERN const CGFloat LEFT_MARGIN;

/** playerHandleView 中控件的右间距*/
UIKIT_EXTERN const CGFloat RIGHT_MARGIN;

/** playerHandleView 中控件的高度*/
UIKIT_EXTERN const CGFloat HEIGHT;

/** player 中视频的比例*/
UIKIT_EXTERN const CGFloat VIDEO_SCALE;


