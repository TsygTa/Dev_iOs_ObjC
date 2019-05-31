//
//  OrdersListViewController.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 15/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "OrdersListViewController.h"
#import "OrdersListCell.h"

@interface OrdersListViewController() <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, DeliveredOrderProtocol>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UISearchController *searchController;

@property (strong, nonatomic) NSMutableArray *orders;
@property (strong, nonatomic) NSArray *filteredArray;

@end

@implementation OrdersListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style: UITableViewStylePlain];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
    
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.dimsBackgroundDuringPresentation = false;
    self.searchController.searchResultsUpdater = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.orders = [[NSMutableArray alloc] initWithArray:[[CoreDataService sharedInstance] orders]];
    self.filteredArray = [self.orders copy];
    [self.tableView reloadData];
    self.tabBarController.navigationItem.title = NSLocalizedString(@"orders", @"");
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if(searchController.searchBar.text.length > 0) {
        self.filteredArray =  [self filterOrders:self.searchController.searchBar.text];
    } else {
        self.filteredArray = [self.orders copy];
    }
    [self.tableView reloadData];
}

- (NSArray *) filterOrders:(NSString *)text {
    
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    for(Order *order in self.orders) {
        NSString *stringForSearch = [[NSString alloc]initWithFormat:@"%@ %@ %@ %@", [[NSNumber alloc] initWithInt:order.number], order.address, order.name, [[NSNumber alloc] initWithInt:order.total]];
        if([stringForSearch containsString:text]) {
            [result addObject: order];
        }
    }
    return [result copy];
}

- (void) deliverOrder: (Order *) order {
    if(order) {
        [[CoreDataService sharedInstance] addDeliveryWithOrder: order];
        [[CoreDataService sharedInstance] removeOrder: order];
        
        self.orders = [[NSMutableArray alloc] initWithArray:[[CoreDataService sharedInstance] orders]];
        if(self.searchController.searchBar.text.length > 0) {
            self.filteredArray =  [self filterOrders:self.searchController.searchBar.text];
        } else {
            self.filteredArray = [self.orders copy];
        }
        [self.tableView reloadData];
    }
}

#pragma mark -- UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredArray.count;
}

-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrdersListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    if(!cell) {
        cell = [[OrdersListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderCell"];
    }
    
    Order *order = self.filteredArray[indexPath.row];
    [cell config: order];
    cell.delegate = self;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

@end
