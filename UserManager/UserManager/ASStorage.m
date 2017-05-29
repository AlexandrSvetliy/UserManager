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
- (BOOL)loadStorage {
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
    return YES;
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
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:usersEntity inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
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
    NSManagedObjectContext *managedObjectContext = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:managedObjectContext];
    
    [newManagedObject setValuesForKeysWithDictionary:[user getUserDictionary]];
    
    NSError *error = nil;
    if(![managedObjectContext save:&error]){
        NSLog(@"Unresolved error: %@, %@", error, [error userInfo]);
        abort();
    }
    return YES;
}
- (BOOL)editUser:(ASUser*)user WithIdentificator:(NSInteger)userID {
    return YES;
}
- (BOOL)removeUser:(ASUser*)user WithIdentificator:(NSInteger)userID {
    return YES;
}
@end
