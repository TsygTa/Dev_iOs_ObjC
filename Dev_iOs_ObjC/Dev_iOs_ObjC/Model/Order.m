//
//  Order.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 15/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "Order.h"

@implementation Order
- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(self) {
        self.number = [dictionary valueForKey:@"number"];
        self.name = [[NSString alloc] initWithFormat:@"%@ %@",[dictionary valueForKey:@"name"],[dictionary valueForKey:@"surname"]];
        self.address = [[NSString alloc] initWithFormat:@"%@ %@ %@",[dictionary valueForKey:@"building"],[dictionary valueForKey:@"street"],[dictionary valueForKey:@"city"]];
        self.phone = [dictionary valueForKey:@"phone"];
        self.total = [dictionary valueForKey:@"total"];
        NSNumber *lng = [dictionary valueForKey:@"longitude"];
        NSNumber *lat = [dictionary valueForKey:@"lattitude"];
        if(![lng isEqual:[NSNull null]] && ![lat isEqual:[NSNull null]]) {
            self.coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
        }
    }
    return self;
}
@end
