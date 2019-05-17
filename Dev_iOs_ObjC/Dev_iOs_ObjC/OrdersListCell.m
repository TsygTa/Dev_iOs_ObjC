//
//  OrdersListCell.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 15/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "OrdersListCell.h"

@interface OrdersListCell ()
@property (nonatomic) Order *order;
@property (nonatomic) Delivery *delivery;
@property NSInteger source;

@property (nonatomic, strong) UILabel *numberAndTotal;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *phoneAndName;
@property (nonatomic, strong) UIButton *deliveredButton;
@end

@implementation OrdersListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.numberAndTotal = [[UILabel alloc] initWithFrame:self.bounds];
        self.numberAndTotal.font = [UIFont systemFontOfSize:15];
        [self.numberAndTotal setTextColor:[UIColor blueColor]];
        [self.contentView addSubview:self.numberAndTotal];
        
        self.address = [[UILabel alloc] initWithFrame:self.bounds];
        self.address.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.address];
        
        self.phoneAndName = [[UILabel alloc] initWithFrame:self.bounds];
        self.phoneAndName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.phoneAndName];
        
        self.deliveredButton = [[UIButton alloc] initWithFrame:self.bounds];
        [self.deliveredButton setTitle:@"Доставлено" forState:UIControlStateNormal];
        self.deliveredButton.backgroundColor = [UIColor greenColor];
        [self.deliveredButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.deliveredButton.layer setCornerRadius:15];
        [self.deliveredButton addTarget: self action:@selector(deliveredButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.deliveredButton setHidden:YES];
        [self.contentView addSubview:self.deliveredButton];
        
    }
    return self;
}

- (void) layoutSubviews {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    self.numberAndTotal.frame = CGRectMake(10, 10, self.bounds.size.width-20, 30);
    self.address.frame = CGRectMake(10, 45, self.bounds.size.width-20, 30);
    self.phoneAndName.frame = CGRectMake(10, 80, self.bounds.size.width-20, 30);
    self.deliveredButton.frame = CGRectMake(10, 125, self.bounds.size.width-20, 30);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    [self.deliveredButton setHidden:YES];
    if(selected == YES && self.source == 0) {
        [self.deliveredButton setHidden:NO];
    }
}

- (void) config:(nullable Order *)order andDelivery:(nullable Delivery *)delivery andSource: (NSInteger) source {
    self.source = source;
    if(source == 0) {
        self.order = order;
        [self.numberAndTotal setText:[[NSString alloc] initWithFormat:@"№ %@   Сумма: %@",order.number, order.total]];
        [self.address setText:[[NSString alloc] initWithFormat:@"Адрес: %@",order.address]];
        [self.phoneAndName setText:[[NSString alloc] initWithFormat:@"Тел: %@   Имя: %@",order.phone, order.name]];
        [self.address setHidden:NO];
        [self.phoneAndName setHidden:NO];
        [self.deliveredButton setHidden:YES];
    } else if(source == 1) {
        self.delivery = delivery;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
        [self.numberAndTotal setText:[[NSString alloc] initWithFormat:@"%@ Заказ №%@   Сумма: %@", [dateFormatter stringFromDate:delivery.date], delivery.orderNumber, delivery.orderTotal]];
        [self.address setHidden:YES];
        [self.phoneAndName setHidden:YES];
        [self.deliveredButton setHidden:YES];
    }
}

-(void) deliveredButtonDidTap:(UIButton *)sender {
    NSLog(@"Заказ %@ доставлен", self.order.number);
    [self.deliveredButton setHidden:YES];
//    [self.delegate deliverOrder:self.indexPath];
}

@end
