//
//  Order+CoreDataProperties.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 29/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//
//

#import "Order+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Order (CoreDataProperties)

+ (NSFetchRequest<Order *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *address;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t number;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nonatomic) int16_t total;

@end

NS_ASSUME_NONNULL_END
