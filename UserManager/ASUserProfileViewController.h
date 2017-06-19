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
#import "ASUser+CoreDataManagerExtention.h"

typedef void (^ObjectHandler)(id);
@interface ASUserProfileViewController : UIViewController
@property (nonatomic, copy) ObjectHandler saveHandler;
//- (void)setStorage:(ASStorage *)storage;
- (void)setCurrentUser:(ASUser*)user;
@end
