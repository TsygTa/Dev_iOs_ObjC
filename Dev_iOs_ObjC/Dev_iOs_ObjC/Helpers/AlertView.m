//
//  AlertView.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 15/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

+ (void) displayMessage:(NSString *) massege {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Внимание!" message:massege preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
//    [self presentViewController:alertController animated:YES completion:nil];
}

@end
