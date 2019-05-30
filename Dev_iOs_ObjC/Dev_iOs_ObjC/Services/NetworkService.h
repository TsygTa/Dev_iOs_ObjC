//
//  NetworkService.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 15/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkService : NSObject

+ (instancetype)sharedInstance;
- (void)getOrders:(NSString*)deviceId withCompletion:(void(^)(NSArray *orders))completion;

@end

NS_ASSUME_NONNULL_END
