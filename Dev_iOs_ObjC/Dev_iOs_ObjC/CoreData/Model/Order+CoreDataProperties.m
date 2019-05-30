//
//  Order+CoreDataProperties.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 29/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//
//

#import "Order+CoreDataProperties.h"

@implementation Order (CoreDataProperties)

+ (NSFetchRequest<Order *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Order"];
}

@dynamic address;
@dynamic latitude;
@dynamic longitude;
@dynamic name;
@dynamic number;
@dynamic phone;
@dynamic total;

@end
