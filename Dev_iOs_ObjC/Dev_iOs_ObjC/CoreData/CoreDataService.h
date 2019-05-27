//
//  CoreDataService.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 27/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderCD+CoreDataClass.h"
#import "DeliveryCD+CoreDataClass.h"
#import "Order.h"
#import "Delivery.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataService : NSObject
+(instancetype)sharedInstance;
- (void)addOrder:(Order *) order;
- (NSArray*)orders;
- (void)removeOrder:(Order *) order;
- (void)addDelivery:(Delivery *) delivery;
- (NSArray*)deliveries;
- (Order *) orderCDToOrder: (OrderCD *) orderCD;
- (Delivery *) deliveryCDToDelirery: (DeliveryCD *) deliveryCD;
@end

NS_ASSUME_NONNULL_END
