//
//  Delivery.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 15/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Order.h"

NS_ASSUME_NONNULL_BEGIN

@interface Delivery : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSNumber *orderNumber;
@property (nonatomic, strong) NSNumber *orderTotal;
@property (nonatomic) CLLocationCoordinate2D coordinate;

- (instancetype) initWithOrder:(Order *)order;
@end

NS_ASSUME_NONNULL_END
