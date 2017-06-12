//
//  UIViewController+ASMessageBox.h
//  UserManager
//
//  Created by Александр Светлый on 01.06.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ASMessageBox)
- (void)showAlertWithMessage:(NSString*)message Title:(NSString*)title;
@end
