//
//  DataManager.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 20/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"
#import "Delivery.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

- (instancetype)sharedInstance;
@property (strong, nonatomic) NSMutableArray *orders;
@property (strong, nonatomic) NSMutableArray *deliveries;

@end

NS_ASSUME_NONNULL_END
