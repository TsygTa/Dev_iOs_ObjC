//
//  OrderCD+CoreDataProperties.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 27/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//
//

#import "OrderCD+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface OrderCD (CoreDataProperties)

+ (NSFetchRequest<OrderCD *> *)fetchRequest;

@property (nonatomic) int16_t number;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nonatomic) int16_t total;
@property (nonatomic) double lattitude;
@property (nonatomic) double longitude;

@end

NS_ASSUME_NONNULL_END
