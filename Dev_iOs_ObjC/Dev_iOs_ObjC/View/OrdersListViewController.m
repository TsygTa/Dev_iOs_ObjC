//
//  OrdersListViewController.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 15/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "OrdersListViewController.h"
#import "OrdersListCell.h"
#import "Order.h"

@interface OrdersListViewController() <UITableViewDataSource, UITableViewDelegate, OrderCellDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;

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
    
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"Новые Заказы", @"Доставлено"]];
    [self.segmentedControl addTarget:self action:@selector(changeSource) forControlEvents:UIControlEventValueChanged];
    [self.segmentedControl setTintColor:[UIColor blackColor]];
    self.navigationItem.titleView = self.segmentedControl;
    self.segmentedControl.selectedSegmentIndex = 0;
    [self changeSource];
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
