//
//  ContentViewController.h
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 30/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentViewController : UIViewController

@property (nonatomic) NSInteger index;

- (id)initWithContent:(NSString *)text withImage:(UIImage *)image forIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
