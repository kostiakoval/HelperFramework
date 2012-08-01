//
//  DataBase.m
//  GymTracker
//
//  Created by Konstantin on 5/7/12.
//  Copyright (c) 2012 nLink.no. All rights reserved.
//

#import "NLCoreDataContextManager.h"

static NSString *sDataBasaFileName = @"DataBase.sqlite";
/**
 Private Methods
 */
@interface NLCoreDataContextManager()

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation NLCoreDataContextManager

@synthesize mainManagedObjectContext = mainManagedObjectContext;
@synthesize managedObjectModel = m_managedObjectModel;
@synthesize persistentStoreCoordinator = m_persistentStoreCoordinator;

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)saveContext:(NSManagedObjectContext*)context
{
    if (context != nil)
    {
        NSError *error = nil;
        if ([context hasChanges] && ![context save:&error])
        {
            [NSException raise:@"NLSaveContextExeption" format:@"Unresolved error %@, %@", error, [error userInfo]];
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (m_managedObjectModel != nil)
    {
        return m_managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    m_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    if (m_managedObjectModel == nil) {
        // NOTE: allBundles permits Core Data setup in unit tests
        m_managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:[NSBundle allBundles]];
    }
    return m_managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (m_persistentStoreCoordinator != nil)
    {
        return m_persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:sDataBasaFileName];
    
    NSError *error = nil;
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    m_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![m_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
    {
        /* Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
        */
        [NSException raise:@"NLPersistentStoreCoordinatorExeption" format:@"Unresolved error %@, %@", error, [error userInfo]];
    }    
    
    return m_persistentStoreCoordinator;
}

#pragma Public Methods 

/**
 Set database file name.
 */
+ (void)dataBaseFileName:(NSString *)name
{
    sDataBasaFileName = name;
}

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)mainManagedObjectContext
{
    if (mainManagedObjectContext != nil)
    {
        return mainManagedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        mainManagedObjectContext = [[NSManagedObjectContext alloc] init];
        [mainManagedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return mainManagedObjectContext;
}

/**
 Create and return new NSManagedObjectContext.
 */
- (NSManagedObjectContext *)newLocalContext
{
    NSManagedObjectContext * newContext = nil;
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        newContext = [[NSManagedObjectContext alloc] init];
        [newContext setPersistentStoreCoordinator:coordinator];
    }
    return newContext;
}







@end
