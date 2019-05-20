//
//  MapViewController.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 18/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "Order.h"
#import "OrdersListViewController.h"
#import "LocationService.h"

@interface MapViewController () <MKMapViewDelegate>

@property(nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) LocationService *myLocation;
@property BOOL isMyLocationStart;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    [self.mapView setDelegate:self];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(((Order *)self.orders[0]).coordinate, 10000, 10000);
    [self.mapView setRegion:region animated:true];
    
    [self.view addSubview:self.mapView];
    self.isMyLocationStart = NO;
    
    UIButton *zoomInButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, [UIScreen mainScreen].bounds.size.height/2 - 85, 50, 50)];
    [zoomInButton setImage:[UIImage imageNamed:@"monitoring_zoom_in_button_icon.png"] forState:UIControlStateNormal];
    zoomInButton.backgroundColor = [UIColor whiteColor];
    zoomInButton.layer.cornerRadius = 25;
    [zoomInButton addTarget: self action:@selector(mapZoomInDidTap:) forControlEvents:UIControlEventTouchDown];
    [self.mapView addSubview:zoomInButton];
    
    UIButton *zoomOutButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, [UIScreen mainScreen].bounds.size.height/2 - 25, 50, 50)];
    [zoomOutButton setImage:[UIImage imageNamed:@"monitoring_zoom_out_button_icon.png"] forState:UIControlStateNormal];
    zoomOutButton.backgroundColor = [UIColor whiteColor];
    zoomOutButton.layer.cornerRadius = 25;
    [zoomOutButton addTarget: self action:@selector(mapZoomOutDidTap:) forControlEvents:UIControlEventTouchDown];
    [self.mapView addSubview:zoomOutButton];
    
    UIButton *myLocationButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, [UIScreen mainScreen].bounds.size.height/2 + 65, 50, 50)];
    [myLocationButton setImage:[UIImage imageNamed:@"monitoring_my_location_button_icon.png"] forState:UIControlStateNormal];
    myLocationButton.backgroundColor = [UIColor whiteColor];
    myLocationButton.layer.cornerRadius = 25;
    [myLocationButton addTarget: self action:@selector(myLocationDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview: myLocationButton];
    
    for(Order *order in self.orders) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.title = [[NSString alloc] initWithFormat:@"Заказ № %@",order.number];
        annotation.subtitle = [[NSString alloc] initWithFormat:@"%@", order.address];
        annotation.coordinate = order.coordinate;
        
        [self.mapView addAnnotation:annotation];
    }
  
    UIButton *ordersListButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 75, [UIScreen mainScreen].bounds.size.height - 50, 150,30)];
    [ordersListButton setTitle:@"Заказы" forState:UIControlStateNormal];
    ordersListButton.backgroundColor = [UIColor whiteColor];
    [ordersListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ordersListButton addTarget: self action:@selector(orderButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview: ordersListButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCurrentLocation:) name:kLocationServiceDidUpdateCurrentLocation object:nil];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) mapZoomInDidTap:(UIButton *)sender {
    CLLocationCoordinate2D center = [self.mapView region].center;
    CLLocationDistance latDelta = [self.mapView region].span.latitudeDelta / 2.0;
    CLLocationDistance lngDelta = [self.mapView region].span.longitudeDelta / 2.0;
    MKCoordinateSpan span = MKCoordinateSpanMake(latDelta, lngDelta);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    
    [self.mapView setRegion:region animated:true];
}

-(void) mapZoomOutDidTap:(UIButton *)sender {
    CLLocationCoordinate2D center = [self.mapView region].center;
    CLLocationDistance latDelta = [self.mapView region].span.latitudeDelta * 2.0;
    CLLocationDistance lngDelta = [self.mapView region].span.longitudeDelta * 2.0;
    MKCoordinateSpan span = MKCoordinateSpanMake(latDelta, lngDelta);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    
    [self.mapView setRegion:region animated:true];
}

-(void) myLocationDidTap:(UIButton *)sender {
    if(self.isMyLocationStart) {
        [self.myLocation stop];
    } else {
        if(!self.myLocation) {
            self.myLocation = [[LocationService alloc] init];
        }
        [self.myLocation start];
    }
}

-(void) orderButtonDidTap:(UIButton *)sender {
    OrdersListViewController *ordersListViewController = [[OrdersListViewController alloc]init];
    ordersListViewController.orders = [self.orders copy];
    [self.navigationController pushViewController:ordersListViewController animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString *identifire = @"MarkerIdentifier";
    MKAnnotationView *annotationView = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifire];
    if (!annotationView) {
        annotationView = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifire];
        annotationView.canShowCallout = true;
        annotationView.calloutOffset = CGPointMake(-5.0, 5.0);
        
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [infoButton addTarget:self action:@selector(pressInfoButton) forControlEvents:UIControlEventTouchUpInside];
        
        annotationView.rightCalloutAccessoryView = infoButton;
    }
    annotationView.annotation = annotation;
    return annotationView;
}

- (void) pressInfoButton {
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[[NSString alloc] initWithFormat:@"Заказ: %@",order.number] message:[[NSString alloc] initWithFormat:@"%@ \nТел: %@   Имя: %@\n Сумма: %@",order.address, order.phone, order.name, order.total] preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleDefault handler:nil]];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void) updateCurrentLocation: (NSNotification *)notification {
    CLLocation *currentLocation = notification.object;
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.title = @"Я";
    annotation.coordinate = currentLocation.coordinate;

    [self.mapView addAnnotation:annotation];
    
}

@end
