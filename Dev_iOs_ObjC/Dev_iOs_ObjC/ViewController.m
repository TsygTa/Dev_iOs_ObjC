//
//  ViewController.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 05.05.2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView* antennaImage;
@property (nonatomic, strong) UIView *gpsMessageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UITextField *orderNumber;
@property (nonatomic, strong) UIButton *orderSendButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 50, 50)];
    logo.image = [UIImage imageNamed:@"Logo.png"];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:logo];
    
    UILabel *appName = [[UILabel alloc] initWithFrame:CGRectMake(75, 50, 200, 50)];
    appName.font = [UIFont systemFontOfSize:32.0 weight: UIFontWeightBold];
    appName.textColor = [UIColor darkGrayColor];
    appName.textAlignment = NSTextAlignmentLeft;
    appName.text = @"Курьер";
    [self.view addSubview:appName];
    
    self.antennaImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 50, 50, 50)];
    self.antennaImage.image = [UIImage imageNamed:@"AntennaGPSOff.png"];
    self.antennaImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.antennaImage];

    self.gpsMessageView = [[UIView alloc]initWithFrame:CGRectMake(20, 110, [UIScreen mainScreen].bounds.size.width - 20, 100)];
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
    [gpsButton addTarget: self action:@selector(GPSButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.gpsMessageView addSubview:gpsButton];
    
    [self.view addSubview:self.gpsMessageView];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.color = [UIColor blackColor];
    self.activityIndicator.frame = self.view.bounds;
    self.activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:self.activityIndicator];
    
    
    self.orderNumber = [[UITextField alloc] initWithFrame:CGRectMake(20, 300, ([UIScreen mainScreen].bounds.size.width - 46)/2, 30)];
    [self.orderNumber.layer setBorderWidth:1];
    [self.orderNumber.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.orderNumber setEnabled:NO];
    [self.orderNumber setPlaceholder:@"Номер заказа"];
    [self.orderNumber setKeyboardType:UIKeyboardTypeNumberPad];
    [self.view addSubview:self.orderNumber];
    
    self.orderSendButton = [[UIButton alloc] initWithFrame:CGRectMake(26+([UIScreen mainScreen].bounds.size.width - 46)/2, 300, ([UIScreen mainScreen].bounds.size.width - 46)/2, 30)];
    [self.orderSendButton setTitle:@"Заказ доставлен" forState:UIControlStateNormal];
    self.orderSendButton.backgroundColor = [UIColor grayColor];
    [self.orderSendButton.layer setCornerRadius:15];
    [self.orderSendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.orderSendButton addTarget: self action:@selector(orderButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.orderSendButton setEnabled:NO];
    [self.view addSubview:self.orderSendButton];
    
}

- (void) displayMessage:(NSString *) massege {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Внимание!" message:massege preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) GPSButtonDidTap:(UIButton *)sender {
    [self.gpsMessageView setHidden:YES];
    [self.activityIndicator startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.activityIndicator stopAnimating];
        self.antennaImage.image = [UIImage imageNamed:@"AntennaGPSOn.png"];
        self.orderSendButton.backgroundColor = [UIColor greenColor];
        [self.orderSendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.orderNumber setEnabled:YES];
        [self.orderSendButton setEnabled:YES];
    });
}

-(void) orderButtonDidTap:(UIButton *)sender {
    if ([self.orderNumber.text length] > 0) {
        [self displayMessage:[[NSString alloc] initWithFormat:@"Информация о доставке Заказа %@ принята", self.orderNumber.text]];
        NSLog(@"Заказ %@ доставлен", self.orderNumber.text);
        self.orderNumber.text = @"";
    } else {
        [self displayMessage:@"Введите номер заказа"];
    }
}

@end
