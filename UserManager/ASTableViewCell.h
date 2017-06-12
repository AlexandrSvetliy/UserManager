//
//  ASTableViewCell.h
//  UserManager
//
//  Created by Александр Светлый on 05.06.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASUser+CoreDataClass.h"

@interface ASTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *userLogin;
@property (strong, nonatomic) IBOutlet UILabel *detailUserInfo;

- (void)fillWithPerson:(ASUser *)user;
@end
