//
//  OrderCD+CoreDataProperties.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 27/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//
//

#import "OrderCD+CoreDataProperties.h"

@implementation OrderCD (CoreDataProperties)

+ (NSFetchRequest<OrderCD *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"OrderCD"];
}

@dynamic number;
@dynamic name;
@dynamic address;
@dynamic phone;
@dynamic total;
@dynamic lattitude;
@dynamic longitude;

@end
