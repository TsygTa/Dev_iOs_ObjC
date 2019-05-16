//
//  OrdersListViewController.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 15/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "OrdersListViewController.h"
#import "NetworkService.h"

@interface OrdersListViewController() <UITableViewDataSource, UITableViewDelegate, OrderCellDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;

@property (strong, nonatomic) NSMutableArray *orders;
@property (strong, nonatomic) NSMutableArray *deliveries;

@property (strong, nonatomic) NSMutableArray *items;

@end

@implementation OrdersListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.deliveries = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style: UITableViewStylePlain];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.color = [UIColor blackColor];
    self.activityIndicator.frame = self.view.bounds;
    self.activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:self.activityIndicator];
    
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"Новые Заказы", @"Доставлено"]];
    [self.segmentedControl addTarget:self action:@selector(changeSource) forControlEvents:UIControlEventValueChanged];
    [self.segmentedControl setTintColor:[UIColor blackColor]];
    self.navigationItem.titleView = self.segmentedControl;
    self.segmentedControl.selectedSegmentIndex = 0;
    [self changeSource];
    
    [self.activityIndicator startAnimating];
    
//    [self prepareOrders];
//    [self.activityIndicator stopAnimating];
//    [self changeSource];
    
    [[NetworkService sharedInstance] getOrders: @"" withCompletion:^(NSArray * _Nonnull orders) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicator stopAnimating];
            if(orders.count <= 0) {
                [self prepareOrders];
            } else {
                self.orders = [orders copy];
            }

            [self changeSource];
        });
    }];
}

- (void) prepareOrders {
    self.orders = [[NSMutableArray alloc] initWithObjects:
                   [[Order alloc] initWithDictionary: @{  @"number": @"555",
                                                          @"name": @"Ольга",
                                                          @"surname": @"Иванова",
                                                          @"building": @"54",
                                                          @"street": @"ул Новая",
                                                          @"city": @"Москва",
                                                          @"longitude": @"0",
                                                          @"latitude": @"0",
                                                          @"phone": @"777-77-77",
                                                          @"total": @"3200"}],
                   [[Order alloc] initWithDictionary: @{  @"number": @"777",
                                                          @"name": @"Петр",
                                                          @"surname": @"Петров",
                                                          @"building": @"5",
                                                          @"street": @"ул Летняя",
                                                          @"city": @"Москва",
                                                          @"longitude": @"0",
                                                          @"latitude": @"0",
                                                          @"phone": @"888-88-88",
                                                          @"total": @"7567"}],
                  nil];
}

- (void) changeSource {
    switch(self.segmentedControl.selectedSegmentIndex) {
        case 0:
            self.items = self.orders;
            break;
        case 1:
            self.items = self.deliveries;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

- (void) deliverOrder: (NSIndexPath *) indexPath {
    Order *order = self.orders[indexPath.row];
    Delivery *delivery = [[Delivery alloc]initWithOrder:order];
    [self.deliveries addObject: delivery];
    
    [self.orders removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self changeSource];
}

#pragma mark -- UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrdersListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    if(!cell) {
        cell = [[OrdersListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderCell"];
    }
    
    if(self.segmentedControl.selectedSegmentIndex == 0) {
        Order *order = self.orders[indexPath.row];
        [cell config:order andDelivery:nil andSource:0];
    }
    
    if(self.segmentedControl.selectedSegmentIndex == 1) {
        Delivery *delivery = self.deliveries[indexPath.row];
        [cell config:nil andDelivery:delivery andSource:1];
    }
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 165;
}

@end
