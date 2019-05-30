//
//  DeliveriesListCell.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 20/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CoreDataService.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeliveriesListCell : UITableViewCell

- (void) config: (Delivery *)delivery;

@end

NS_ASSUME_NONNULL_END
