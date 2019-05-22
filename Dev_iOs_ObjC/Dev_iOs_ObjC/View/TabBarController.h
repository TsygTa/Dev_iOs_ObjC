//
//  TabBarController.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 20/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TabBarController : UITabBarController

- (instancetype) initWithDataManager:(DataManager *) dataManager;
@property (strong, nonatomic) DataManager *dataManager;

@end

NS_ASSUME_NONNULL_END
