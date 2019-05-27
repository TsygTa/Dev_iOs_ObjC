//
//  CoreDataService.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 27/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//
#import "CoreDataService.h"
#import <CoreData/CoreData.h>

@interface CoreDataService ()

@property (nonatomic, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, strong) NSManagedObjectContext *context;

@end

#import "CoreDataService.h"

@implementation CoreDataService
+ (instancetype)sharedInstance {
    static CoreDataService *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataService alloc] init];
        [instance setup];
    });
    
    return instance;
}

- (void)setup {
    self.persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Courier"];
    [self.persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * description, NSError * error) {
        if (error != nil) {
            NSLog(@"Ошибка инициализации CoreData");
            abort();
        }
        self.context = self.persistentContainer.viewContext;
    }];
}

- (void)save {
    NSError *error;
    [self.context save:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}


- (void)addOrder:(Order *)order {
    OrderCD *item = [NSEntityDescription insertNewObjectForEntityForName:@"OrderCD" inManagedObjectContext:self.context];
    item.number = [order.number intValue];
    item.name = order.name;
    item.address = order.address;
    item.phone = order.phone;
    item.total = [order.total intValue];
    item.lattitude = [order coordinate].latitude;
    item.longitude = [order coordinate].longitude;
    [self save];
}

- (NSArray*)orders {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"OrderCD"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"number" ascending:true]];
    return [self.context executeFetchRequest:request error:nil];
}

- (void) removeOrder:(OrderCD *)order {
    [self.context deleteObject:order];
    [self save];
}

- (NSArray*)deliveries {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DeliveryCD"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:true]];
    return [self.context executeFetchRequest:request error:nil];
}

- (void)addDelivery:(Delivery *)delivery {
    DeliveryCD *item = [NSEntityDescription insertNewObjectForEntityForName:@"DeliveryCD" inManagedObjectContext:self.context];
    
    item.date = [delivery.date timeIntervalSince1970];
    item.orderNumber = [delivery.orderNumber intValue];
    item.orderTotal = [delivery.orderTotal intValue];
    item.lattitude = [delivery coordinate].latitude;
    item.longitude = [delivery coordinate].longitude;
    [self save];
}

- (Order *) orderCDToOrder: (OrderCD *) orderCD {
    Order * order = [[Order alloc] init];
    order.number = [[NSNumber alloc] initWithInt:orderCD.number];
    order.name = orderCD.name;
    order.address = orderCD.address;
    order.phone = orderCD.phone;
    order.total = [[NSNumber alloc] initWithInt:orderCD.total];
    order.coordinate = CLLocationCoordinate2DMake(orderCD.lattitude, orderCD.longitude);
    return order;
}

- (Delivery *) deliveryCDToDelirery: (DeliveryCD *) deliveryCD {
    Delivery * delivery = [[Delivery alloc] init];
    delivery.orderNumber = [[NSNumber alloc] initWithInt:deliveryCD.orderNumber];
    delivery.date = [[NSDate alloc] initWithTimeIntervalSince1970:deliveryCD.date];
    delivery.orderTotal = [[NSNumber alloc] initWithInt:deliveryCD.orderTotal];
    delivery.coordinate = CLLocationCoordinate2DMake(deliveryCD.lattitude, deliveryCD.longitude);
    return delivery;
}
@end
