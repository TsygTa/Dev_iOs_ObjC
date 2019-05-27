//
//  DeliveryCD+CoreDataProperties.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 27/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//
//

#import "DeliveryCD+CoreDataProperties.h"

@implementation DeliveryCD (CoreDataProperties)

+ (NSFetchRequest<DeliveryCD *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"DeliveryCD"];
}

@dynamic date;
@dynamic orderNumber;
@dynamic orderTotal;
@dynamic deviceId;
@dynamic lattitude;
@dynamic longitude;

@end
