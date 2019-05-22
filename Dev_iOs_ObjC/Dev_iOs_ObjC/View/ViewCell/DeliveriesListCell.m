//
//  DeliveriesListCell.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 20/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "DeliveriesListCell.h"

#import "DeliveriesListCell.h"

@interface DeliveriesListCell ()

@property (nonatomic) Delivery *delivery;

@property (nonatomic, strong) UILabel *numberAndTotal;
@property (nonatomic, strong) UILabel *dateLabel;
@end

@implementation DeliveriesListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.numberAndTotal = [[UILabel alloc] initWithFrame:self.bounds];
        self.numberAndTotal.font = [UIFont systemFontOfSize:15];
        [self.numberAndTotal setTextColor:[UIColor blueColor]];
        [self.contentView addSubview:self.numberAndTotal];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.dateLabel.font = [UIFont systemFontOfSize:15];
        [self.dateLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.dateLabel];
    }
    return self;
}

- (void) layoutSubviews {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    self.numberAndTotal.frame = CGRectMake(10, 10, self.bounds.size.width-20, 30);
    self.dateLabel.frame = CGRectMake(10, 45, self.bounds.size.width-20, 30);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void) config:(Delivery *)delivery {

    self.delivery = delivery;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
    [self.numberAndTotal setText:[[NSString alloc] initWithFormat:@"Заказ №%@   Сумма: %@", delivery.orderNumber, delivery.orderTotal]];
    [self.dateLabel setText:[[NSString alloc] initWithFormat:@"Доставлено: %@", [dateFormatter stringFromDate:delivery.date]]];
}

@end
