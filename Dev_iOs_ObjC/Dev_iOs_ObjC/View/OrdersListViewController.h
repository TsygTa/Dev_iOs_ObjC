//
//  OrdersListViewController.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 15/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataService.h"

@protocol DeliveredOrderProtocol <NSObject>

- (void) deliverOrder: (Order *) order;

@end

@interface OrdersListViewController : UIViewController

@end
