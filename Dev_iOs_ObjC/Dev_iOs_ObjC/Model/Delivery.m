//
//  Delivery.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 15/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "Delivery.h"

@implementation Delivery

- (instancetype) initWithOrder:(Order *)order {
    self = [super init];
    if(self) {
        self.date = [NSDate date];
        self.deviceId = @"";
        self.orderNumber = order.number;
        self.orderTotal = order.total;
        self.coordinate = order.coordinate;
    }
    return self;
}
@end
