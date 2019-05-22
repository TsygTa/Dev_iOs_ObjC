//
//  DeliveriesListViewController.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 20/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "DeliveriesListViewController.h"
#import "DeliveriesListCell.h"

@interface DeliveriesListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation DeliveriesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style: UITableViewStylePlain];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark -- UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataManager.deliveries.count;
}

-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DeliveriesListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeliveryCell"];
    if(!cell) {
        cell = [[DeliveriesListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DeliveryCell"];
    }
    
    Delivery *delivery = self.dataManager.deliveries[indexPath.row];
    [cell config: delivery];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

@end
