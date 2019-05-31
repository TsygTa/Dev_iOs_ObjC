//
//  MainViewController.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 05.05.2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "MainViewController.h"
#import "TabBarController.h"
#import "NetworkService.h"
#import "CoreDataService.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import "PageViewController.h"
#import "ProgressView.h"

#define TEST_FLAG 1

@interface MainViewController () <UNUserNotificationCenterDelegate>

@property (nonatomic, strong) UIImageView* antennaImage;
@property (nonatomic, strong) UIView *gpsMessageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"";
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Success");
        }
    }];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 50, 50)];
    logo.image = [UIImage imageNamed:@"Logo.png"];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:logo];
    
    UILabel *appName = [[UILabel alloc] initWithFrame:CGRectMake(75, 100, 200, 50)];
    appName.font = [UIFont systemFontOfSize:32.0 weight: UIFontWeightBold];
    appName.textColor = [UIColor darkGrayColor];
    appName.textAlignment = NSTextAlignmentLeft;
    appName.text = NSLocalizedString(@"courier", @"");
    [self.view addSubview:appName];
    
    self.antennaImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 100, 50, 50)];
    self.antennaImage.image = [UIImage imageNamed:@"AntennaGPSOn.png"];
    self.antennaImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.antennaImage];

    self.gpsMessageView = [[UIView alloc]initWithFrame:CGRectMake(20, 160, [UIScreen mainScreen].bounds.size.width - 20, 100)];
    self.gpsMessageView.backgroundColor = [UIColor whiteColor];
    
    UILabel *gpsOffMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.gpsMessageView.bounds.size.width, 60)];
    gpsOffMessage.font = [UIFont systemFontOfSize:16.0 weight: UIFontWeightBold];
    gpsOffMessage.textColor = [UIColor darkGrayColor];
    gpsOffMessage.textAlignment = NSTextAlignmentLeft;
    gpsOffMessage.numberOfLines = 0;
    gpsOffMessage.text = @"GPS Выключен, чтобы определить\nваше местоположение";
    [self.gpsMessageView addSubview:gpsOffMessage];
    
    UIButton *gpsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 65, 200, 30)];
    [gpsButton setTitle:@"Включите геолокацию" forState:UIControlStateNormal];
    gpsButton.backgroundColor = [UIColor whiteColor];
    [gpsButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [gpsButton addTarget: self action:@selector(gpsButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.gpsMessageView addSubview:gpsButton];
    
    //[self.view addSubview:self.gpsMessageView];
    
    UIButton *ordersListButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 80, [UIScreen mainScreen].bounds.size.height/2-50, 160,30)];
    [ordersListButton setTitle:NSLocalizedString(@"orders", @"") forState:UIControlStateNormal];
    ordersListButton.backgroundColor = [UIColor whiteColor];
    [ordersListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ordersListButton.layer.borderWidth = 1;
    ordersListButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [ordersListButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [ordersListButton.layer setShadowOffset:CGSizeMake(5,5)];
    [ordersListButton.layer setShadowOpacity: 0.5];
    [ordersListButton setShowsTouchWhenHighlighted:YES];
    [ordersListButton addTarget: self action:@selector(orderButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [ordersListButton setHidden:YES];
    [self.view addSubview: ordersListButton];
    
    UIButton *aboutApplicationButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 80, [UIScreen mainScreen].bounds.size.height/2 + 50, 160,30)];
    [aboutApplicationButton setTitle:NSLocalizedString(@"aboutApp", @"") forState:UIControlStateNormal];
    aboutApplicationButton.backgroundColor = [UIColor whiteColor];
    [aboutApplicationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    aboutApplicationButton.layer.borderWidth = 1;
    aboutApplicationButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [aboutApplicationButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [aboutApplicationButton.layer setShadowOffset:CGSizeMake(5,5)];
    [aboutApplicationButton.layer setShadowOpacity: 0.5];
    [aboutApplicationButton setShowsTouchWhenHighlighted:YES];
    [aboutApplicationButton addTarget: self action:@selector(aboutApplicationButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [aboutApplicationButton setHidden:YES];
    [self.view addSubview: aboutApplicationButton];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.color = [UIColor blackColor];
    self.activityIndicator.frame = self.view.bounds;
    self.activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:self.activityIndicator];
    
//    [self.activityIndicator startAnimating];
    [[ProgressView sharedInstance] show: ^{}];
    
#if TEST_FLAG
    [self prepareOrders];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        //[self.activityIndicator stopAnimating];
        [[ProgressView sharedInstance] dismiss: ^{
         [ordersListButton setHidden:NO];
         [aboutApplicationButton setHidden:NO];
         }];
    });
#else
    [[NetworkService sharedInstance] getOrders: @"" withCompletion:^(NSArray * _Nonnull arrayJSON) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(arrayJSON.count <= 0) {
                [self prepareOrders];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                });
            } else {
                for (int i=0; i<arrayJSON.count; i++) {
                    NSDictionary *json = arrayJSON[i];
                    [[CoreDataService sharedInstance] addOrderWithDictionary: arrayJSON[i]];
                }
            }
            //[self.activityIndicator stopAnimating];
            [[ProgressView sharedInstance] dismiss: ^{
                 [ordersListButton setHidden:NO];
                 [aboutApplicationButton setHidden:NO];
             }];
        });
    }];
#endif
}
                
-(void) gpsButtonDidTap:(UIButton *)sender {
    [self.gpsMessageView setHidden:YES];
    [self.activityIndicator startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.activityIndicator stopAnimating];
        self.antennaImage.image = [UIImage imageNamed:@"AntennaGPSOn.png"];
    });
}

- (void) prepareOrders {
    NSArray *orders = [[NSArray alloc] initWithObjects:
                   @{ @"number": @"555",
                      @"name": @"Ольга",
                      @"surname": @"Иванова",
                      @"building": @"6",
                      @"street": @"ул. 2-я Черногрязская",
                      @"city": @"Москва",
                      @"longitude": @"37.548151",
                      @"latitude": @"55.761629",
                      @"phone": @"777-77-77",
                      @"total": @"3200"},
                   @{ @"number": @"777",
                      @"name": @"Петр",
                      @"surname": @"Петров",
                      @"building": @"137",
                      @"street": @"Ленинский проспект",
                      @"city": @"Москва",
                      @"longitude": @"37.472279",
                      @"latitude": @"55.642047",
                      @"phone": @"888-88-88",
                      @"total": @"7567"},
                   @{ @"number": @"77",
                      @"name": @"Ирина",
                      @"surname": @"Сидорова",
                      @"building": @"7",
                      @"street": @"ул Цюрупы",
                      @"city": @"Москва",
                      @"longitude": @"37.573510)",
                      @"latitude": @"55.666127",
                      @"phone": @"999-99-99",
                      @"total": @"7800"},
                    @{ @"number": @"99",
                      @"name": @"Зоя",
                      @"surname": @"Кузнецова",
                      @"building": @"91",
                      @"street": @"Ленинский проспект",
                      @"city": @"Москва",
                      @"longitude": @"37.529789",
                      @"latitude": @"55.676646",
                      @"phone": @"111-11-11",
                      @"total": @"9200"},
                    @{  @"number": @"44",
                      @"name": @"Елена",
                      @"surname": @"Власова",
                      @"building": @"31",
                      @"street": @"Каширское шоссе",
                      @"city": @"Москва",
                      @"longitude": @"37.664384",
                      @"latitude": @"55.649865",
                      @"phone": @"333-33-33",
                      @"total": @"3000"},
                   nil];
    for (int i=0; i< orders.count; i++) {
        [[CoreDataService sharedInstance] addOrderWithDictionary:orders[i]];
    }
}


- (void) orderButtonDidTap:(UIButton *)sender {
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"Внимание!";
    content.body = @"Новый заказ";
    content.sound = [UNNotificationSound defaultCriticalSound];
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar componentsInTimeZone:[NSTimeZone systemTimeZone]
                                                         fromDate:[NSDate new]];
    NSDateComponents *newComponents = [[NSDateComponents alloc] init];
    newComponents.calendar = calendar;
    newComponents.timeZone = [NSTimeZone defaultTimeZone];
    newComponents.month = components.month;
    newComponents.day = components.day;
    newComponents.hour = components.hour;
    newComponents.minute = components.minute;
    newComponents.second = components.second + 10;
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:newComponents repeats:false];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Notification"
                                                                          content:content
                                                                          trigger:trigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:nil];
    
    TabBarController *tabBarController = [[TabBarController alloc]init];
    [self.navigationController pushViewController:tabBarController animated:YES];
}

- (void) aboutApplicationButtonDidTap:(UIButton *)sender {
    
    PageViewController *pageViewController = [[PageViewController alloc] init];
    
    [self.navigationController pushViewController:pageViewController animated:YES];
}
                   
@end

