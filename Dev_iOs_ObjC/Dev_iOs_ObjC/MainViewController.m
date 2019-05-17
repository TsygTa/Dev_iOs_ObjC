//
//  MainViewController.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 05.05.2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) UIImageView* antennaImage;
@property (nonatomic, strong) UIView *gpsMessageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIButton *ordersListButton;

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
    self.antennaImage.image = [UIImage imageNamed:@"AntennaGPSOff.png"];
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
    
    [self.view addSubview:self.gpsMessageView];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.color = [UIColor blackColor];
    self.activityIndicator.frame = self.view.bounds;
    self.activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:self.activityIndicator];
    
//    self.orderNumber = [[UITextField alloc] initWithFrame:CGRectMake(20, 350, ([UIScreen mainScreen].bounds.size.width - 46)/2, 30)];
//    [self.orderNumber.layer setBorderWidth:1];
//    [self.orderNumber.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//    [self.orderNumber setEnabled:NO];
//    [self.orderNumber setPlaceholder:@"Номер заказа"];
//    [self.orderNumber setKeyboardType:UIKeyboardTypeNumberPad];
//    [self.view addSubview:self.orderNumber];
    
    self.ordersListButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100, [UIScreen mainScreen].bounds.size.height - 100, 200,50)];
    [self.ordersListButton setTitle:@"Заказы" forState:UIControlStateNormal];
    self.ordersListButton.backgroundColor = [UIColor lightGrayColor];
    [self.ordersListButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.ordersListButton addTarget: self action:@selector(orderButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.ordersListButton setEnabled:NO];
    [self.view addSubview:self.ordersListButton];
}

-(void) gpsButtonDidTap:(UIButton *)sender {
    [self.gpsMessageView setHidden:YES];
    [self.activityIndicator startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.activityIndicator stopAnimating];
        self.antennaImage.image = [UIImage imageNamed:@"AntennaGPSOn.png"];
        self.ordersListButton.backgroundColor = [UIColor lightGrayColor];
        [self.ordersListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.ordersListButton setEnabled:YES];
    });
}

-(void) orderButtonDidTap:(UIButton *)sender {
    OrdersListViewController *ordersListViewController = [[OrdersListViewController alloc]init];
    [self.navigationController pushViewController:ordersListViewController animated:YES];
}

@end
