//
//  ASStorage.m
//  UserManager
//
//  Created by Александр Светлый on 13.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASStorage.h"

static NSString* const usersEntity = @"Users";

@interface ASStorage()
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation ASStorage
- (instancetype)init {
    self = [super init];
    if (self) {
        _fetchedResultsController = nil;
        _managedObjectModel = nil;
        _managedObjectContext = nil;
        _persistentStoreCoordinator = nil;
    }
    return self;
}
- (NSFetchRequest*)fetchRequest {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:usersEntity inManagedObjectContext:context];
    [request setEntity:entity];
    return request;
}
- (BOOL)isUserExistWithFormat:(NSString*)format AndArguments:(NSArray*)arguments {
    NSFetchRequest *request = [self fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:format argumentArray:arguments];
    return [self.managedObjectContext countForFetchRequest:request error:nil] > 0;
}
- (ASUser*)getUserWithLogin:(NSString*)login {
//    ASUser *user = [[ASUser alloc] init];
    NSFetchRequest *request = [self fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"login == %@" argumentArray:@[login]];
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!result) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    for(ASUser *object in result) {
        NSLog(@"Found %@", [object valueForKey:@"login"]);
//        ASUser*user = [[ASUser alloc] initWithDictionary:
//                        [object dictionaryWithValuesForKeys:@[@"login",@"firstName",@"lastName",@"email",@"gender",@"country",@"birthday",@"icon",@"password"]]];
        return object;
    }
//    NSManagedObject *object = nil;
//    
//    [object dictionaryWithValuesForKeys:result];
//    NSManagedObjectContext *context = [self managedObjectContext];
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:usersEntity inManagedObjectContext:context];
//    [request setEntity:entity];
//    NSArray *results = [context executeFetchRequest:request error:nil];
//    
//    for(NSManagedObject *object in results){
//        NSLog(@"Found %@", [object valueForKey:@"login"]);
//    }
//    
//    NSString *launchTitle = [NSString stringWithFormat:@"launch %lu", (unsigned long)[results count]];
//    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
//    [object setValue:launchTitle forKey:@"login"];
//    [self saveContext];
//    NSLog(@"Added : %@", launchTitle);
    
    //[self.window makeKeyAndVisible];
    return nil;
}
- (BOOL)cleanStorage {
    return YES;
}
- (NSManagedObjectContext *)managedObjectContext {
    if(_managedObjectContext){
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if(coordinator){
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}
- (NSManagedObjectModel *)managedObjectModel {
    if(_managedObjectModel != nil){
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DataModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}
- (NSURL *)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    if(managedObjectContext != nil) {
        if([managedObjectContext hasChanges] && ![managedObjectContext save:&error]){
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if(_persistentStoreCoordinator){
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"UserManager.sqlite"];
    
    NSError* error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}
- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController)
        return _fetchedResultsController;
    
    NSFetchRequest *fetchRequest = [self fetchRequest];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"login" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    _fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if(![_fetchedResultsController performFetch:&error]){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}
- (BOOL)addUser:(ASUser*)user {
    if (!user && [self isUserExistWithFormat:@"login == %@" AndArguments: @[user.login]]) return NO;
    NSManagedObjectContext *managedObjectContext = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    ASUser *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:managedObjectContext];
    
    newManagedObject = user;
    //[newManagedObject setValuesForKeysWithDictionary:[user getUserDictionary]];
    
    NSError *error = nil;
    if(![managedObjectContext save:&error]){
        NSLog(@"Unresolved error: %@, %@", error, [error userInfo]);
        abort();
    }
    return YES;
}
- (BOOL)editUser:(ASUser*)user {
    if (user && [self isUserExistWithFormat:@"login == %@" AndArguments: @[user.login]]) {
        NSFetchRequest *request = [self fetchRequest];
        request.predicate = [NSPredicate predicateWithFormat:@"login == %@" argumentArray:@[user.login]];
        NSError *error = nil;
        ASUser *resultUser = [[self.managedObjectContext executeFetchRequest:request error:&error] objectAtIndex:0];
        if (!resultUser) {
            NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
            abort();
        }
        [self saveContext];
    }
    return YES;
}
- (BOOL)removeUser:(ASUser*)user WithIdentificator:(NSInteger)userID {
    return YES;
}
- (NSArray*)getAllUsers {
    NSMutableArray *users = [[NSMutableArray alloc] init];
    NSFetchRequest *request = [self fetchRequest];
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!result) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
//    ASUser *user = nil;
    NSInteger index = 0;
    for(ASUser *user in result) {
        NSLog(@"Load %@...", [user valueForKey:@"login"]);
//        user = [[ASUser alloc] initWithDictionary:
//                       [object dictionaryWithValuesForKeys:@[@"login",@"firstName",@"lastName",@"email",@"gender",@"country",@"birthday",@"icon",@"password"]]];
//        user = object;
        [users insertObject:user atIndex:index];
        ++index;
    }
    NSLog(@"All users loaded...");
    return [users copy];
}
@end
