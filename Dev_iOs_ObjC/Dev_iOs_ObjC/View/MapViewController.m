//
//  MapViewController.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 18/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController() <MKMapViewDelegate>

@property(nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) LocationService *locationService;
@property (nonatomic, strong) MKPointAnnotation *myLocationMarker;

@property BOOL isMyLocationStart;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    [self.mapView setDelegate:self];
    
    [self.view addSubview:self.mapView];
    self.isMyLocationStart = false;
    
    [self centerMapOnOrder];
    
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
    [self showOrdersOnMap];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCurrentLocation:) name:kLocationServiceDidUpdateCurrentLocation object:nil];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView removeAnnotations:[self.mapView annotations]];
    [self showOrdersOnMap];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) centerMapOnOrder {
    MKCoordinateRegion region;
    if(self.dataManager.orders.count > 0) {
        region = MKCoordinateRegionMakeWithDistance(((Order *)self.dataManager.orders[0]).coordinate, 20000, 20000);
    } else {
        region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(55.751999, 37.617734), 20000, 20000);
    }
    [self.mapView setRegion:region animated:true];
}

- (void) showOrdersOnMap {
    for(Order *order in self.dataManager.orders) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.title = [[NSString alloc] initWithFormat:@"Заказ № %@",order.number];
        annotation.subtitle = [[NSString alloc] initWithFormat:@"%@\nСумма: %@\nТел: %@\nИмя: %@", order.address, order.total, order.phone, order.name];
        annotation.coordinate = order.coordinate;
        
        [self.mapView addAnnotation:annotation];
    }
    for(Delivery *delivery in self.dataManager.deliveries) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
        annotation.title = [[NSString alloc] initWithFormat:@"Доставлено № %@",delivery.orderNumber];
        annotation.subtitle = [[NSString alloc] initWithFormat:@"Заказ №%@\nСумма: %@\nДоставлено: %@", delivery.orderNumber, delivery.orderTotal, [dateFormatter stringFromDate:delivery.date]];
        annotation.coordinate = delivery.coordinate;
        
        [self.mapView addAnnotation:annotation];
    }
}

- (void) showMyLocation {
    if(self.location) {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.location.coordinate, 20000, 20000);
        [self.mapView setRegion:region animated:true];
        self.myLocationMarker = [[MKPointAnnotation alloc] init];
        self.myLocationMarker.title = @"Я";
        self.myLocationMarker.coordinate = self.location.coordinate;
        [self.mapView addAnnotation:self.myLocationMarker];
    }
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
        [self.locationService stop];
        self.isMyLocationStart = false;
        //[self.mapView setShowsUserLocation:false];
        if(self.myLocationMarker) {
            [self.mapView removeAnnotation:self.myLocationMarker];
        }
        [self centerMapOnOrder];
    } else {
        if(!self.locationService) {
            self.locationService = [[LocationService alloc] init];
        }
        [self.locationService start];
        self.isMyLocationStart = true;
        //[self.mapView setShowsUserLocation:true];
        if(self.myLocationMarker) {
            [self.mapView removeAnnotation:self.myLocationMarker];
        }
        
        self.location = self.locationService.currentLocation;
        [self showMyLocation];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    //MKPinAnnotationView - можно менять цвет
    static NSString *identifire = @"MarkerIdentifier";
    MKAnnotationView *annotationView = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifire];
    if (!annotationView) {
        annotationView = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifire];
        annotationView.canShowCallout = true;
        annotationView.calloutOffset = CGPointMake(-5.0, 5.0);
    }
    AnnotationInfoButton *infoButton = [AnnotationInfoButton buttonWithType:UIButtonTypeDetailDisclosure];
    infoButton.annotation = [[MKPointAnnotation alloc] init];
    infoButton.annotation = annotation;
    [infoButton addTarget:self action:@selector(pressInfoButton:) forControlEvents:UIControlEventTouchUpInside];
    
    annotationView.rightCalloutAccessoryView = infoButton;
    
    annotationView.annotation = annotation;
    return annotationView;
}

- (void) pressInfoButton: (AnnotationInfoButton *) sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:sender.annotation.title message: sender.annotation.subtitle preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void) updateCurrentLocation: (NSNotification *)notification {
    
    if(self.isMyLocationStart) {
        self.location = (CLLocation *)notification.object;
        if(self.myLocationMarker) {
            [self.mapView removeAnnotation:self.myLocationMarker];
        }
        [self showMyLocation];
    }
}

@end
