//
//  GDPlayerView.h
//  GDPlayerExample
//
//  Created by 林广德 on 16/5/22.
//  Copyright © 2016年 林广德. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDConstant.h"

@interface GDPlayerView : UIView
@property (nonatomic, copy) PlayerProgress playerProgress;
- (void)gd_playerWithUrl:(NSURL *)url;
- (void)gd_playerWithUrl:(NSURL *)url playerProgress:(PlayerProgress)playerProgress;



@end
