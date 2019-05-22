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

#define TEST_FLAG 1

@interface MainViewController ()

@property (nonatomic, strong) UIImageView* antennaImage;
@property (nonatomic, strong) UIView *gpsMessageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 50, 50)];
    logo.image = [UIImage imageNamed:@"Logo.png"];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:logo];
    
    UILabel *appName = [[UILabel alloc] initWithFrame:CGRectMake(75, 100, 200, 50)];
    appName.font = [UIFont systemFontOfSize:32.0 weight: UIFontWeightBold];
    appName.textColor = [UIColor darkGrayColor];
    appName.textAlignment = NSTextAlignmentLeft;
    appName.text = @"Курьер";
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
    
    UIButton *ordersListButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 75, [UIScreen mainScreen].bounds.size.height/2 + 40, 150,30)];
    [ordersListButton setTitle:@"Заказы" forState:UIControlStateNormal];
    ordersListButton.backgroundColor = [UIColor whiteColor];
    [ordersListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ordersListButton.layer.borderWidth = 1;
    ordersListButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [ordersListButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [ordersListButton.layer setShadowOffset:CGSizeMake(5,5)];
    [ordersListButton.layer setShadowOpacity: 0.5];
    [ordersListButton setShowsTouchWhenHighlighted:YES];
    
    [ordersListButton addTarget: self action:@selector(orderButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: ordersListButton];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.color = [UIColor blackColor];
    self.activityIndicator.frame = self.view.bounds;
    self.activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:self.activityIndicator];
    
    [self.activityIndicator startAnimating];
    self.dataManager.orders = [[NSMutableArray alloc] init];
    self.dataManager.deliveries = [[NSMutableArray alloc] init];
    
#if TEST_FLAG
    [self prepareOrders];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.activityIndicator stopAnimating];
        [self prepareOrdersCoordinates];
        TabBarController *tabBarController = [[TabBarController alloc]initWithDataManager: self.dataManager];
        [self.navigationController pushViewController:tabBarController animated:YES];
    });
#else
    [[NetworkService sharedInstance] getOrders: @"" withCompletion:^(NSArray * _Nonnull orders) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(orders.count <= 0) {
                [self prepareOrders];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                });
            } else {
                self.dataManager.orders = [orders copy];
            }
            [self.activityIndicator stopAnimating];
            [self prepareOrdersCoordinates];
            TabBarController *tabBarController = [[TabBarController alloc]initWithDataManager: self.dataManager];
            [self.navigationController pushViewController:tabBarController animated:YES];
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
    self.dataManager.orders = [[NSMutableArray alloc] initWithObjects:
                   [[Order alloc] initWithDictionary: @{  @"number": @"555",
                                                          @"name": @"Ольга",
                                                          @"surname": @"Иванова",
                                                          @"building": @"6",
                                                          @"street": @"ул. 2-я Черногрязская",
                                                          @"city": @"Москва",
                                                          @"longitude": @"0",
                                                          @"latitude": @"0",
                                                          @"phone": @"777-77-77",
                                                          @"total": @"3200"}],
                   [[Order alloc] initWithDictionary: @{  @"number": @"777",
                                                          @"name": @"Петр",
                                                          @"surname": @"Петров",
                                                          @"building": @"137",
                                                          @"street": @"Ленинский проспект",
                                                          @"city": @"Москва",
                                                          @"longitude": @"0",
                                                          @"latitude": @"0",
                                                          @"phone": @"888-88-88",
                                                          @"total": @"7567"}],
                   [[Order alloc] initWithDictionary: @{  @"number": @"77",
                                                          @"name": @"Ирина",
                                                          @"surname": @"Сидорова",
                                                          @"building": @"7",
                                                          @"street": @"ул Цюрупы",
                                                          @"city": @"Москва",
                                                          @"longitude": @"0",
                                                          @"latitude": @"0",
                                                          @"phone": @"999-99-99",
                                                          @"total": @"7800"}],
                   [[Order alloc] initWithDictionary: @{  @"number": @"99",
                                                          @"name": @"Зоя",
                                                          @"surname": @"Кузнецова",
                                                          @"building": @"91",
                                                          @"street": @"Ленинский проспект",
                                                          @"city": @"Москва",
                                                          @"longitude": @"0",
                                                          @"latitude": @"0",
                                                          @"phone": @"111-11-11",
                                                          @"total": @"9200"}],
                   [[Order alloc] initWithDictionary: @{  @"number": @"44",
                                                          @"name": @"Елена",
                                                          @"surname": @"Власова",
                                                          @"building": @"31",
                                                          @"street": @"Каширское шоссе",
                                                          @"city": @"Москва",
                                                          @"longitude": @"0",
                                                          @"latitude": @"0",
                                                          @"phone": @"333-33-33",
                                                          @"total": @"3000"}],
                   nil];
}

- (void) prepareOrdersCoordinates {
    
    ((Order *) self.dataManager.orders[0]).coordinate = CLLocationCoordinate2DMake(55.761629, 37.548151);
    ((Order *) self.dataManager.orders[1]).coordinate = CLLocationCoordinate2DMake(55.642047, 37.472279);
    ((Order *) self.dataManager.orders[2]).coordinate = CLLocationCoordinate2DMake(55.666127, 37.573510);
    ((Order *) self.dataManager.orders[3]).coordinate = CLLocationCoordinate2DMake(55.676646, 37.529789);
    ((Order *) self.dataManager.orders[4]).coordinate = CLLocationCoordinate2DMake(55.649865, 37.664384);
}

-(void) orderButtonDidTap:(UIButton *)sender {
    TabBarController *tabBarController = [[TabBarController alloc]initWithDataManager: self.dataManager];
    [self.navigationController pushViewController:tabBarController animated:YES];
}
                   
@end

