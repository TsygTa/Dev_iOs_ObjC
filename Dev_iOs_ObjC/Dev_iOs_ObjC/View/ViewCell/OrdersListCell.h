//
//  OrdersListCell.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 15/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "OrdersListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrdersListCell : UITableViewCell

@property (nonatomic, strong) UIViewController <DeliveredOrderProtocol> *delegate;

- (void) config:(Order *)order;

@end


NS_ASSUME_NONNULL_END
