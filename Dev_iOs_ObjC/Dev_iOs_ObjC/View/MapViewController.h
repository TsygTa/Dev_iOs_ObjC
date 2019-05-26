//
//  MapViewController.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 18/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationService.h"
#import "DataManager.h"
#import "AnnotationInfoButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController

@property (strong, nonatomic) DataManager *dataManager;
@property (nonatomic, strong) CLLocation *location;

@end

NS_ASSUME_NONNULL_END
