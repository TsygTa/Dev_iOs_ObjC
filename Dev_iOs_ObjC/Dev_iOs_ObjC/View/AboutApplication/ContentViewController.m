//
//  ContentViewController.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 30/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation ContentViewController

- (id)initWithContent:(NSString *)text withImage:(UIImage *)image forIndex:(NSInteger)index {
    self = [super init];
    
    if (self) {
        [self.view setBackgroundColor:[UIColor lightGrayColor]];
        self.index = index;
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, self.view.bounds.size.width-40, 100)];
        self.textLabel.numberOfLines = 0;
        self.textLabel.font = [UIFont systemFontOfSize:20.0 weight: UIFontWeightBold];
        [self.textLabel setText:text];
        [self.view addSubview:self.textLabel];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 200, self.view.bounds.size.width - 100, self.view.bounds.size.height - 400)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.imageView setImage:image];
        [self.view addSubview:self.imageView];
        
    }
    return self;
}

@end
