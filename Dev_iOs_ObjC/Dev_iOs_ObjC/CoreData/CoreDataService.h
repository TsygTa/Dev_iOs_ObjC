//
//  CoreDataService.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 27/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order+CoreDataClass.h"
#import "Delivery+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataService : NSObject
+ (instancetype) sharedInstance;
- (void)addOrderWithDictionary:(NSDictionary *)dictionary;
- (NSArray*) orders;
- (void) removeOrder:(Order *) order;
- (void) addDeliveryWithOrder:(Order *) order;
- (NSArray*) deliveries;
@end

NS_ASSUME_NONNULL_END
