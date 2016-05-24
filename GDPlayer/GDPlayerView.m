//
//  GDPlayerView.m
//  GDPlayerExample
//
//  Created by 林广德 on 16/5/22.
//  Copyright © 2016年 林广德. All rights reserved.
//

#import "GDPlayerView.h"
#import "GDPlayer.h"
#import "GDPlayerHandleView.h"
#import "Masonry.h"
#import "GDDefine.h"
@interface GDPlayerView ()
@property (nonatomic, weak) GDPlayerHandleView *handleView;
@property (nonatomic, strong) GDPlayer *player;




@end
@implementation GDPlayerView



- (void)gd_playerWithUrl:(NSURL *)url{
    [self gd_playerWithUrl:url playerProgress:self.playerProgress];
}
- (void)gd_playerWithUrl:(NSURL *)url playerProgress:(PlayerProgress)playerProgress {
    GDPlayer *player = [[GDPlayer alloc] init];
    [player gd_playerWithUrl:url toView:self playerProgress:playerProgress];
    self.player = player;
    self.handleView.player = player;
    self.playerProgress = player.playerProgress;
}

- (void)setPlayerProgress:(PlayerProgress)playerProgress{
    _playerProgress = playerProgress;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        GDPlayerHandleView *handleView = [[GDPlayerHandleView alloc] initWithPlayer:self.player];
        self.handleView = handleView;
        [self addSubview:self.handleView];
        
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    kWeakSelf(weakSelf);
    [self.handleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
        make.height.mas_equalTo(44);
    }];
}



@end
