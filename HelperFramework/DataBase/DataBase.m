//
//  DataBase.m
//  GymTracker
//
//  Created by Konstantin on 5/7/12.
//  Copyright (c) 2012 nLink.no. All rights reserved.
//

#import "DataBase.h"

static NSString *sDataBasaFileName = @"DataBase.sqlite";
/**
 Private Methods
 */
@interface DataBase()

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation DataBase

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
            [NSException raise:@"saveContextExeption" format:@"Unresolved error %@, %@", error, [error userInfo]];
            abort();
        } 
    }
}

#pragma mark - Core Data stack

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
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return m_persistentStoreCoordinator;
}

#pragma Public Methods 

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
