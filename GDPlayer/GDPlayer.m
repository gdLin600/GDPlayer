//
//  GDPlayer.m
//  GDPlayerExample
//
//  Created by 林广德 on 16/5/22.
//  Copyright © 2016年 林广德. All rights reserved.
//

#import "GDPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "GDConstant.h"
#import "GDDefine.h"
@interface GDPlayer (){
    CGFloat _duration;//总时长
    CGFloat _loadedProgress;//缓冲进度
}
@property (nonatomic, strong) AVAsset *asset;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@end
@implementation GDPlayer


- (void)gd_playerWithUrl:(NSURL *)url toView:(UIView *)showView{
    [self gd_playerWithUrl:url toView:showView playerProgress:self.playerProgress];
}

- (void)gd_playerWithUrl:(NSURL *)url toView:(UIView *)showView playerProgress:(PlayerProgress)playerProgress{
    self.playerProgress = playerProgress;
    self.asset = [AVAsset assetWithURL:url];
    _duration = CMTimeGetSeconds(self.asset.duration);
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.asset];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    CGFloat W = showView.bounds.size.width;
    CGFloat H = W * VIDEO_SCALE;
    CGFloat X = 0;
    CGFloat Y = showView.bounds.size.height * .5 - H * .5;
    self.playerLayer.frame = CGRectMake(X, Y, W, H);
    [showView.layer insertSublayer:self.playerLayer atIndex:0];
    [self gd_play];
}




- (void)setPlayerProgress:(PlayerProgress)playerProgress{
    _playerProgress = playerProgress;
    if (_playerProgress) {
        _playerProgress(_duration);
    }
}





- (void)gd_play{
    [self gd_playPlayerProgress:self.playerProgress];
    
}

- (void)gd_playPlayerProgress:(PlayerProgress)playerProgress{
    if (!self.player) return;
    self.playerProgress = playerProgress;
    if (self.player.status == AVPlayerStatusReadyToPlay) {
        [self.player pause];
    }
    [self addNotification];
    [self.player play];
}


- (void)addNotification{
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [self.playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    [self.playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            //            [self monitoringPlayback:playerItem];// 给播放器添加计时器
            
            
        } else if ([playerItem status] == AVPlayerStatusFailed || [playerItem status] == AVPlayerStatusUnknown) {
            [self gd_stop];
        }
        
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {  //监听播放器的下载进度
        
        [self calculateDownloadProgress:playerItem];
        
    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) { //监听播放器在缓冲数据的状态
        if (playerItem.isPlaybackBufferEmpty) {
            //            self.state = TBPlayerStateBuffering;
            //            [self bufferingSomeSecond];
        }
    }
}

- (void)calculateDownloadProgress:(AVPlayerItem *)playerItem{
    NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
    CMTime duration = playerItem.duration;
    CGFloat totalDuration = CMTimeGetSeconds(duration);
    _loadedProgress = timeInterval / totalDuration;
}

- (void)gd_resume {
    [self seekToTime:0.0];
    [self gd_play];
}
//TODO: 需要进行停止操作
- (void)gd_stop {
    if (!self.player) return;
    //    if (self.player.status == AVPlayerStatusReadyToPlay) {
    //        [self.player ];
    //    }
    
}



- (void)gd_pause {
    if (!self.player) return;
    if (self.player.status == AVPlayerStatusReadyToPlay) {
        [self.player pause];
    }
}



- (void)seekToTime:(CGFloat)seconds{
    seconds = MAX(0, seconds);
    seconds = MIN(seconds, _duration);
    [self gd_pause];
    [self.player seekToTime:CMTimeMakeWithSeconds(seconds, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
        
    }];
}

- (void)dealloc{
    self.playerProgress = nil;
}






@end
