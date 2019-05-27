//
//  DeliveryCD+CoreDataProperties.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 27/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//
//

#import "DeliveryCD+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DeliveryCD (CoreDataProperties)

+ (NSFetchRequest<DeliveryCD *> *)fetchRequest;

@property (nonatomic) int64_t date;
@property (nonatomic) int16_t orderNumber;
@property (nonatomic) int16_t orderTotal;
@property (nonatomic) int16_t deviceId;
@property (nonatomic) double lattitude;
@property (nonatomic) double longitude;

@end

NS_ASSUME_NONNULL_END
