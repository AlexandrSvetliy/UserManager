//
//  ASStorage.h
//  UserManager
//
//  Created by Александр Светлый on 13.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ASUser.h"

@interface ASStorage : NSObject <NSFetchedResultsControllerDelegate>
- (BOOL)loadStorage;
- (BOOL)addUser   :(ASUser*)user;
- (BOOL)editUser  :(ASUser*)user WithIdentificator:(NSInteger)userID;
- (BOOL)removeUser:(ASUser*)user WithIdentificator:(NSInteger)userID;
@end
