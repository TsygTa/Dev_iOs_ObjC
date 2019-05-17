//
//  NetworkService.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 15/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//
#import "NetworkService.h"

#define API_URL @"https://app.fakejson.com/q"

@implementation NetworkService

+ (instancetype)sharedInstance {
    static NetworkService *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetworkService alloc] init];
    });
    return instance;
}

- (void) load: (NSString*)url withCompletion:(void(^)(id _Nullable result))completion {
    NSDictionary *headers = @{ @"Content-Type": @"application/json"};
    NSDictionary *parameters = @{ @"token": @"3kAGomOweEwu8YrcV76_-g",
                                  @"parameters": @{ @"code": @200 },
                                  @"data": @{ @"number": @"numberInt|1,1000", @"name": @"nameFirst", @"surname": @"nameLast", @"building": @"addressBuilding", @"street": @"addressStreetName", @"city": @"addressCity", @"longitude": @"addressLongitude", @"latitude": @"addressLatitude", @"phone": @"phoneMobile", @"total": @"numberInt|10,500", @"_repeat": @5 } };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError *error) {
                if (error) {
                    NSLog(@"%@", error);
                } else {
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                    NSLog(@"%@", httpResponse);
                    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    completion(result);
                }
            }];
    [dataTask resume];
}

- (void)getOrders:(NSString*)deviceId withCompletion:(void(^)(NSArray *orders))completion {
    // Получаем курсы валют
    [self load:API_URL withCompletion:^(id  _Nullable result) {
        NSArray *arrayJSON = result;
        
        NSMutableArray *resultOrders = [NSMutableArray new];
        
        for (int i=0; i<arrayJSON.count; i++) {
            NSDictionary *json = arrayJSON[i];
            
            [resultOrders addObject:[[Order alloc] initWithDictionary:json]];
        }
        completion(resultOrders);
    }];
}

@end
