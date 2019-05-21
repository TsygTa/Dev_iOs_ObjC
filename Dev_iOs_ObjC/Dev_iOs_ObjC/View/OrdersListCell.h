//
//  OrdersListCell.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 15/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "Delivery.h"

NS_ASSUME_NONNULL_BEGIN

@protocol OrderCellDelegate <NSObject>
@required

- (void) deliverOrder: (NSIndexPath *) indexPath;

@end

@interface OrdersListCell : UITableViewCell

@property (nonatomic, strong) UIViewController <OrderCellDelegate> *delegate;

- (void) config:(nullable Order *)order andDelivery:(nullable Delivery *)delivery andSource: (NSInteger) source;

@end


NS_ASSUME_NONNULL_END
