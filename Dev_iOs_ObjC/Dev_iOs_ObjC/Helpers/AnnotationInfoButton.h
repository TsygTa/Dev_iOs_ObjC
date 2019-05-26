//
//  AnnotationInfoButton.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 22/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnnotationInfoButton : UIButton

@property (nonatomic, strong) MKPointAnnotation *annotation;

@end

NS_ASSUME_NONNULL_END
