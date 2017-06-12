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
#import "ASUser+CoreDataClass.h"

@interface ASStorage : NSObject <NSFetchedResultsControllerDelegate>
- (ASUser*)getUserWithLogin:(NSString*)login;
- (BOOL)addUser   :(ASUser*)user;
- (BOOL)editUser  :(ASUser*)user;
- (BOOL)removeUser:(ASUser*)user WithIdentificator:(NSInteger)userID;
- (BOOL)isUserExistWithFormat:(NSString*)format AndArguments:(NSArray*)arguments;
- (NSArray*)getAllUsers;
@end
