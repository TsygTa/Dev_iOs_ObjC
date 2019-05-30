//
//  ProgressView.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 30/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressView : UIView
+ (instancetype)sharedInstance;

- (void) show: (void(^)(void))completion;
- (void) dismiss: (void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
