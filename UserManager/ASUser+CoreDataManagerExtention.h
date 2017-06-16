//
//  ASUser+CoreDataManagerExtention.h
//  UserManager
//
//  Created by Александр Светлый on 16.06.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASUser+CoreDataClass.h"
#import "ASStorage.h"

@interface ASUser (CoreDataManagerExtention)

+ (NSArray *)users;
+ (ASUser *)addUserWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)usersSearchedWithString:(NSString *)string;

+ (ASUser *)getUserWithLogin:(NSString *)login;
+ (BOOL)isUserExistWithFormat:(NSString*)format AndArguments:(NSArray*)arguments;
- (void)updateUserWithDictionary:(NSDictionary *)dictionary;
- (void)remove;

@end
