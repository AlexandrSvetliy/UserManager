//
//  UIViewController+ASMessageBox.m
//  UserManager
//
//  Created by Александр Светлый on 01.06.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "UIViewController+ASMessageBox.h"

@implementation UIViewController (ASMessageBox)
- (void)showAlertWithMessage:(NSString*)message Title:(NSString*)title {
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title  message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertView addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertView animated:YES completion:nil];
}
@end
