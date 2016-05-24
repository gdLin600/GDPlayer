//
//  GDPlayer.h
//  GDPlayerExample
//
//  Created by 林广德 on 16/5/22.
//  Copyright © 2016年 林广德. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDConstant.h"

@interface GDPlayer : NSObject

@property (nonatomic, assign) GDPlayerState playerState;

@property (nonatomic, copy) PlayerProgress playerProgress;

- (void)gd_playerWithUrl:(NSURL *)url toView:(UIView *)showView;

- (void)gd_playerWithUrl:(NSURL *)url toView:(UIView *)showView playerProgress:(PlayerProgress)playerProgress;

/**
 *  播放
 */
- (void)gd_play;

- (void)gd_playPlayerProgress:(PlayerProgress)playerProgress;

/**
 *  重播
 */
- (void)gd_resume;

/**
 *  停止
 */
- (void)gd_stop;

/**
 *  暂停
 */
- (void)gd_pause;




@end
