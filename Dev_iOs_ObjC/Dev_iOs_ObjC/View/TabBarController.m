//
//  TabBarController.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 20/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "TabBarController.h"
#import "MapViewController.h"
#import "OrdersListViewController.h"
#import "DeliveriesListViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (instancetype) initWithDataManager:(DataManager *) dataManager {
    self = [super init];
    self.dataManager = dataManager;
    if(self) {
        MapViewController *mapViewController = [[MapViewController alloc]init];
        mapViewController.dataManager = self.dataManager;
        
        mapViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Карта" image:[self prepareImage:[UIImage imageNamed:@"map_icon"]] tag:0];
        
        OrdersListViewController *ordersViewController = [[OrdersListViewController alloc]init];
        ordersViewController.dataManager = self.dataManager;
        ordersViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Список" image:[self prepareImage:[UIImage imageNamed:@"list_icon"]] tag:1];
        
        DeliveriesListViewController *deliveriesViewController = [[DeliveriesListViewController alloc]init];
        deliveriesViewController.dataManager = self.dataManager;
        deliveriesViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Доставлено" image:[self prepareImage:[UIImage imageNamed:@"done_icon"]] tag:2];;
        
        self.viewControllers = @[mapViewController,ordersViewController,deliveriesViewController];
        self.tabBar.tintColor = [UIColor blackColor];
        self.selectedIndex = 0;
    }
    return self;
}
         
 - (UIImage *) prepareImage: (UIImage*) image {
     CGRect rect = CGRectMake(0, 0, 24, 24);
     UIGraphicsBeginImageContext(rect.size);
     [image drawInRect:rect];
     UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     return result;
 }

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
