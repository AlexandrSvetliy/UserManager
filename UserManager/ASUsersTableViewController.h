//
//  ASUsersTableViewController.h
//  UserManager
//
//  Created by Александр Светлый on 04.06.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ASStorage.h"
#import "ASUser+CoreDataManagerExtention.h"
#import "ASTableViewCell.h"

@interface ASUsersTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *usersTableView;
@end
