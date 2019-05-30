//
//  ProgressView.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 30/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ProgressView.h"

@implementation ProgressView {
    BOOL isActive;
}
+ (instancetype)sharedInstance {
    static ProgressView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ProgressView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        [instance setup];
    });
    return instance;
}

- (void)setup {
    UIImageView * backGroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    backGroundImageView.image = [UIImage imageNamed:@"cloud"];
    backGroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    backGroundImageView.clipsToBounds = YES;
    [self addSubview:backGroundImageView];
    
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    blurView.frame = self.bounds;
    [self addSubview:blurView];
    
    [self createParsels];
}

- (void) createParsels {
    for(int i=1; i<6; i++) {
        UIImageView *parsel = [[UIImageView alloc] initWithFrame:CGRectMake(-50.0, ((float)i*50.0)+100, 50, 50)];
        parsel.tag = i;
        parsel.image = [UIImage imageNamed:@"parsel"];
        [self addSubview:parsel];
    }
}

- (void) startAnimating:(NSInteger) parselId {
    if(!isActive) return;
    if(parselId >= 6) parselId = 1;
    
    UIImageView *parsel = [self viewWithTag:parselId];
    
    if(parsel) {
        [UIView animateWithDuration:1.0 animations:^{
            parsel.frame = CGRectMake(self.bounds.size.width, parsel.frame.origin.y, 50.0, 50.0);
        } completion:^(BOOL finished) {
            parsel.frame = CGRectMake(-50.0, parsel.frame.origin.y, 50.0, 50.0);
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self startAnimating:parselId+1];
        });
    }
}

- (void) show: (void(^)(void)) completion {
    self.alpha = 0.0;
    isActive = YES;
    [self startAnimating:1];
    [[[UIApplication sharedApplication]keyWindow]addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void) dismiss: (void(^)(void)) completion {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self->isActive = NO;
        if(completion) {
            completion();
        }
    }];
}
@end
