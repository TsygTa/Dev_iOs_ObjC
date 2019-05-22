//
//  OrdersListViewController.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 15/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@protocol DeliveredOrderProtocol <NSObject>

- (void) deliverOrder: (NSNumber *) orderNumber;

@end

@interface OrdersListViewController : UIViewController

@property (strong, nonatomic) DataManager *dataManager;

@end
