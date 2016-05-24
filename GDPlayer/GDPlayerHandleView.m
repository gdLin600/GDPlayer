//
//  GDPlayerHandleView.m
//  GDPlayerExample
//
//  Created by 林广德 on 16/5/22.
//  Copyright © 2016年 林广德. All rights reserved.
//

#import "GDPlayerHandleView.h"
#import "Masonry.h"
#import "GDConstant.h"
#import "GDDefine.h"
@interface GDPlayerHandleView()
/** 播放暂停*/
@property (nonatomic, weak) UIButton       *playPauseBtn;
/** 当前时间*/
@property (nonatomic, weak) UILabel        *currentTimeLb;
/** 缓冲*/
@property (nonatomic, weak) UIProgressView *bufferPro;
/** 进度条*/
@property (nonatomic, weak) UISlider       *playSlider;
/** 总时间*/
@property (nonatomic, weak) UILabel        *durationTimeLb;
/** 全屏*/
@property (nonatomic, weak) UIButton       *fullScreenBtn;

@end

@implementation GDPlayerHandleView

- (instancetype)initWithPlayer:(GDPlayer *)player {
    if (self = [super init]) {
        self.player = player;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0]];
        [self addSubviews];
    }
    return self;
}

- (void)setPlayer:(GDPlayer *)player{
    _player = player;
    player.playerProgress = ^(NSInteger duration){
        [self.durationTimeLb setText:[NSString stringWithFormat:@"%zd",duration]];
        GDLog(@"%zd",duration);
    };
}



- (void)addSubviews{
    
    UIButton *playPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playPauseBtn addTarget:self action:@selector(playPauseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [playPauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [playPauseBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [playPauseBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _playPauseBtn = playPauseBtn;
    [self addSubview:self.playPauseBtn];
    
    UILabel *currentTimeLb = [[UILabel alloc] init];
    [currentTimeLb setText:@"2121212"];
    [currentTimeLb setFont:[UIFont systemFontOfSize:11]];
    self.currentTimeLb = currentTimeLb;
    [self addSubview:currentTimeLb];
    
    UIProgressView *bufferPro = [[UIProgressView alloc] init];
    bufferPro.progressTintColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];  //填充部分颜色
    bufferPro.trackTintColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.2];   // 未填充部分颜色
    bufferPro.layer.cornerRadius = 1.5;
    bufferPro.layer.masksToBounds = YES;
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0, 1.5);
    bufferPro.transform = transform;
    self.bufferPro  = bufferPro;
    [self addSubview:bufferPro];
    
    
    
    UISlider *playSlider = [[UISlider alloc] init];
    self.playSlider = playSlider;
    //    [_playSlider setThumbImage:[UIImage imageNamed:@"icon_progress"] forState:UIControlStateNormal];
    _playSlider.minimumTrackTintColor = [UIColor clearColor];
    _playSlider.maximumTrackTintColor = [UIColor clearColor];
    [_playSlider addTarget:self action:@selector(playSliderChange:) forControlEvents:UIControlEventValueChanged]; //拖动滑竿更新时间
    [_playSlider addTarget:self action:@selector(playSliderChangeEnd:) forControlEvents:UIControlEventTouchUpInside];  //松手,滑块拖动停止
    [_playSlider addTarget:self action:@selector(playSliderChangeEnd:) forControlEvents:UIControlEventTouchUpOutside];
    [_playSlider addTarget:self action:@selector(playSliderChangeEnd:) forControlEvents:UIControlEventTouchCancel];
    [self addSubview:_playSlider];
    
    
    UILabel *durationTimeLb = [[UILabel alloc] init];
    [durationTimeLb setText:@"2121212"];
    [durationTimeLb setFont:[UIFont systemFontOfSize:11]];
    self.durationTimeLb = durationTimeLb;
    [self addSubview:durationTimeLb];
    
    
    UIButton *fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fullScreenBtn addTarget:self action:@selector(fullScreenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [fullScreenBtn setTitle:@"全屏" forState:UIControlStateNormal];
    [fullScreenBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [fullScreenBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.fullScreenBtn = fullScreenBtn;
    [self addSubview:self.fullScreenBtn];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    kWeakSelf(weakSelf);
    [self.playPauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.leftMargin.mas_equalTo(LEFT_MARGIN);
        make.height.mas_equalTo(HEIGHT);
    }];
    
    [self.currentTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.playPauseBtn.mas_right).mas_offset(LEFT_MARGIN);
        make.centerY.mas_equalTo(weakSelf.playPauseBtn);
    }];
    
    [self.bufferPro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.currentTimeLb);
        make.left.mas_equalTo(weakSelf.currentTimeLb.mas_right).mas_offset(LEFT_MARGIN);
        make.right.mas_equalTo(weakSelf.durationTimeLb.mas_left).mas_offset(-RIGHT_MARGIN);
    }];
    
    [self.playSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf.bufferPro);
        make.size.mas_equalTo(weakSelf.bufferPro);
    }];
    
    [self.durationTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.currentTimeLb);
        make.left.mas_equalTo(weakSelf.bufferPro.mas_right).mas_offset(LEFT_MARGIN);
        make.right.mas_equalTo(weakSelf.fullScreenBtn.mas_left).mas_offset(-RIGHT_MARGIN);
    }];
    
    [self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.rightMargin.mas_equalTo(-RIGHT_MARGIN);
        make.height.mas_equalTo(HEIGHT);
    }];
}

- (void)playPauseBtnClick:(UIButton *)btn{
    GDLog(@"%@",self.player.playerProgress);
    [self.player gd_pause];
}

- (void)fullScreenBtnClick:(UIButton *)btn{
    GDLog(@"%@",btn.currentTitle);
}

- (void)playSliderChange:(UISlider *)slider{
    GDLog(@"%@",slider);
}

- (void)playSliderChangeEnd:(UISlider *)slider{
    GDLog(@"%@",slider);
}





@end
