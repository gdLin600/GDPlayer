//
//  GDPlayerHandleView.h
//  GDPlayerExample
//
//  Created by 林广德 on 16/5/22.
//  Copyright © 2016年 林广德. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDPlayerView.h"
#import "GDPlayer.h"
@interface GDPlayerHandleView : UIView
@property (nonatomic, strong) GDPlayer *player;

- (instancetype)initWithPlayer:(GDPlayer *)player;

@end
