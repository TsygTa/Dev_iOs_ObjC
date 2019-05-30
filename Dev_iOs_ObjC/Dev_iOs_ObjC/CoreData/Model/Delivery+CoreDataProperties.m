//
//  Delivery+CoreDataProperties.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 29/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//
//

#import "Delivery+CoreDataProperties.h"

@implementation Delivery (CoreDataProperties)

+ (NSFetchRequest<Delivery *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Delivery"];
}

@dynamic date;
@dynamic deviceId;
@dynamic latitude;
@dynamic longitude;
@dynamic orderNumber;
@dynamic orderTotal;

@end
