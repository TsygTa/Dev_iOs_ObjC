//
//  Delivery+CoreDataProperties.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 29/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//
//

#import "Delivery+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Delivery (CoreDataProperties)

+ (NSFetchRequest<Delivery *> *)fetchRequest;

@property (nonatomic) int64_t date;
@property (nonatomic) int16_t deviceId;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) int16_t orderNumber;
@property (nonatomic) int16_t orderTotal;

@end

NS_ASSUME_NONNULL_END
