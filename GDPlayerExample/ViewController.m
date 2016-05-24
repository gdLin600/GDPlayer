//
//  ViewController.m
//  GDPlayerExample
//
//  Created by 林广德 on 16/5/22.
//  Copyright © 2016年 林广德. All rights reserved.
//

#import "ViewController.h"
#import "GDPlayer.h"
#import "GDPlayerView.h"
#import "GDDefine.h"
@interface ViewController ()
@property (nonatomic, strong) GDPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    /*_player = [[GDPlayer alloc] init];
     NSURL *url = [NSURL URLWithString:@"http://baobab.wdjcdn.com/14571455324031.mp4"];
     [_player gd_playerWithUrl:url toView:self.view];*/
    
    GDPlayerView *v = [[GDPlayerView alloc] init];
    [self.view addSubview:v];
    v.playerProgress = ^(NSInteger du){
        GDLog(@"%zd",du);
    };
    v.frame = self.view.bounds;
    NSURL *url = [NSURL URLWithString:@"http://baobab.wdjcdn.com/14571455324031.mp4"];
    [v gd_playerWithUrl:url];
    
    
}


- (IBAction)gd_play:(id)sender {
    [_player gd_play];
}

/**
 *  重播
 */
- (IBAction)gd_resume:(id)sender {
    [_player gd_resume];
}


/**
 *  停止
 */

- (IBAction)gd_stop:(id)sender {
    [_player gd_stop];
}

/**
 *  暂停
 */

- (IBAction)gd_pause:(id)sender {
    [_player gd_pause];
}



@end
