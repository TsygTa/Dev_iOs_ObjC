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
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Order"];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    [self.context executeRequest:delete error:nil];
    
    request = [[NSFetchRequest alloc] initWithEntityName:@"Delivery"];
    delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    [self.context executeRequest:delete error:nil];
}

- (void)save {
    NSError *error;
    [self.context save:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (void)addOrderWithDictionary:(NSDictionary *)dictionary {
    Order *item = [NSEntityDescription insertNewObjectForEntityForName:@"Order" inManagedObjectContext:self.context];
    item.number = [[dictionary valueForKey:@"number"] intValue];
    item.name = [[NSString alloc] initWithFormat:@"%@ %@",[dictionary valueForKey:@"name"],[dictionary valueForKey:@"surname"]];
    item.address = [[NSString alloc] initWithFormat:@"%@ %@ %@",[dictionary valueForKey:@"building"],[dictionary valueForKey:@"street"],[dictionary valueForKey:@"city"]];
    item.phone = [dictionary valueForKey:@"phone"];
    item.total = [[dictionary valueForKey:@"total"] doubleValue];
    item.latitude = [[dictionary valueForKey:@"latitude"] doubleValue];
    item.longitude = [[dictionary valueForKey:@"longitude"] doubleValue];
    [self save];
}

- (NSArray*)orders {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Order"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"number" ascending:true]];
    return [self.context executeFetchRequest:request error:nil];
}

- (void) removeOrder:(Order *)order {
    [self.context deleteObject:order];
    [self save];
}

- (NSArray*)deliveries {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Delivery"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:true]];
    return [self.context executeFetchRequest:request error:nil];
}

- (void) addDeliveryWithOrder: (Order *)order {
    Delivery *item = [NSEntityDescription insertNewObjectForEntityForName:@"Delivery" inManagedObjectContext:self.context];
    
    item.date = [[NSDate date] timeIntervalSince1970];
    item.orderNumber = order.number;
    item.orderTotal = order.total;
    item.latitude = order.latitude;
    item.longitude = order.longitude;
    [self save];
}
@end
