//
//  OrdersListCell.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 15/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "OrdersListCell.h"
#import "Order.h"

@interface OrdersListCell ()
@property (nonatomic) Order *order;

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
        [self.deliveredButton addTarget: self action:@selector(deliveredButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.deliveredButton setShowsTouchWhenHighlighted:YES];
        [self.deliveredButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [self.deliveredButton.layer setShadowOffset:CGSizeMake(5,5)];
        [self.deliveredButton.layer setShadowOpacity: 0.5];
        [self.deliveredButton setHidden:YES];
        [self.contentView addSubview:self.deliveredButton];
        
    }
    return self;
}

- (void) layoutSubviews {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    self.numberAndTotal.frame = CGRectMake(10, 5, self.bounds.size.width-20, 30);
    self.address.frame = CGRectMake(10, 38, self.bounds.size.width-20, 30);
    self.phoneAndName.frame = CGRectMake(10, 72, self.bounds.size.width-20, 30);
    self.deliveredButton.frame = CGRectMake(10, 105, self.bounds.size.width-20, 30);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    [self.deliveredButton setHidden:YES];
    if(selected == YES) {
        [self.deliveredButton setHidden:NO];
    }
}

- (void) config:(Order *)order {
    self.order = order;
    
    [self.numberAndTotal setText:[[NSString alloc] initWithFormat:@"№ %@   Сумма: %@",order.number, order.total]];
    [self.address setText:[[NSString alloc] initWithFormat:@"Адрес: %@",order.address]];
    [self.phoneAndName setText:[[NSString alloc] initWithFormat:@"Тел: %@   Имя: %@",order.phone, order.name]];
    [self.deliveredButton setHidden:YES];
}

-(void) deliveredButtonDidTap:(UIButton *)sender {
    [self.delegate deliverOrder:self.order.number];
    NSLog(@"Заказ %@ доставлен", self.order.number);
    [self.deliveredButton setHidden:YES];
}

@end
