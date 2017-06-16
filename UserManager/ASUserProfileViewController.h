//
//  ASUserProfileViewController.h
//  UserManager
//
//  Created by Александр Светлый on 04.06.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASUIButton.h"
#import "ASStorage.h"
#import "NSDate+ASDate.h"

static NSString* const ASUsersListSequeID = @"ASUsersListSequeID";

@interface ASUserProfileViewController : UIViewController
//- (void)setStorage:(ASStorage *)storage;
- (void)setCurrentUser:(ASUser*)user;
@end
