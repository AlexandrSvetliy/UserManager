//
//  ASUser+CoreDataManagerExtention.m
//  UserManager
//
//  Created by Александр Светлый on 16.06.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASUser+CoreDataManagerExtention.h"

@implementation ASUser (CoreDataManagerExtention)
+ (NSArray *)users {
    NSManagedObjectContext *context = [[ASStorage sharedInstanse] managedObjectContext];
    
    NSError *error = nil;
    
    NSFetchRequest *request = [self fetchRequest];
    request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"login" ascending:YES]];
//    request.predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"firstname", @"Anna"];
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if (objects == nil) {
        NSLog(@"There was an error!");
    }
    
    return objects;
}
+ (NSArray *)usersSearchedWithString:(NSString *)string {
    NSArray *parameters = [[string stringByReplacingOccurrencesOfString:@"," withString:@" "] componentsSeparatedByString:@" "];
    NSLog(@"%@", parameters);
    
    if (parameters.count > 2) {
        NSString *firstName = parameters[0];
        NSString *lastName = parameters[1];
        NSString *country = parameters[2];
        
        NSError *error = nil;
        NSFetchRequest *request = [self fetchRequest];
        request.predicate = [NSPredicate predicateWithFormat:@"firstname == %@ AND lastname == %@ AND address.country == %@", firstName, lastName, country];
        
        return [[[ASStorage sharedInstanse] managedObjectContext] executeFetchRequest:request error:&error];
    }
    
    return nil;
}
+ (BOOL)isUserExistWithFormat:(NSString*)format AndArguments:(NSArray*)arguments {
    NSFetchRequest *request = [self fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:format argumentArray:arguments];
    return [[[ASStorage sharedInstanse] managedObjectContext] countForFetchRequest:request error:nil] > 0;
}
- (void)updateUserWithDictionary:(NSDictionary *)dictionary {
    [self setUserWithDictionary:dictionary];
    [[ASStorage sharedInstanse] saveContext];
}
- (void)save {
//    [self updateUserWithDictionary:[self dictionaryRepresentation]];
    [[ASStorage sharedInstanse] saveContext];
}
+ (ASUser *)addUserWithDictionary:(NSDictionary *)dictionary {
    ASStorage *dataController = [ASStorage sharedInstanse];
    NSManagedObjectContext *context = [dataController managedObjectContext];
    
    ASUser *user = [NSEntityDescription insertNewObjectForEntityForName:usersEntity inManagedObjectContext:context];
    [user updateUserWithDictionary:dictionary];
    
    return user;
}
- (void)remove {
    ASStorage *storage = [ASStorage sharedInstanse];
    [storage.managedObjectContext deleteObject:self];
    [storage saveContext];
}

+ (ASUser *)getUserWithLogin:(NSString *)login {
    NSFetchRequest *request = [self fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"login == %@" argumentArray:@[login]];
    NSError *error = nil;
    NSArray *result = [[[ASStorage sharedInstanse] managedObjectContext] executeFetchRequest:request error:&error];
    if (!result) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    return [result objectAtIndex:0];
}
@end
