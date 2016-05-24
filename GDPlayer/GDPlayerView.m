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
    
    //    [self addGestureRecognizers];
    
}

- (void)addGestureRecognizers{
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftOrRightSwipe:)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftOrRightSwipe:)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer:rightSwipe];
    
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upOrDownSwipe:)];
    [upSwipe setDirection:UISwipeGestureRecognizerDirectionUp];
    [self addGestureRecognizer:upSwipe];
    
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upOrDownSwipe:)];
    [downSwipe setDirection:UISwipeGestureRecognizerDirectionDown];
    [self addGestureRecognizer:downSwipe];
}

/**
 UISwipeGestureRecognizerDirectionRight = 1 << 0,右 ==1
 UISwipeGestureRecognizerDirectionLeft  = 1 << 1,左 ==2
 UISwipeGestureRecognizerDirectionUp    = 1 << 2,上 ==4
 UISwipeGestureRecognizerDirectionDown  = 1 << 3,下 ==8
 */
- (void)leftOrRightSwipe:(UISwipeGestureRecognizer *)swipe{
    GDLog(@"21212");
}

- (void)upOrDownSwipe:(UISwipeGestureRecognizer *)swipe{
    
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

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint previousLocation = [[[touches allObjects] lastObject] previousLocationInView:self];
    CGPoint currentLocation = [[[touches allObjects] lastObject] locationInView:self];
    [self.handleView gd_updatePlayTimeSeconds:(currentLocation.x - previousLocation.x)];
}


















@end
