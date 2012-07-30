//
//  NLCoreDataFetch.m
//  HelperFramework
//
//  Created by Konstantin on 7/30/12.
//  Copyright (c) 2012 nLink. All rights reserved.
//

#import "NLCoreDataFetch.h"

@implementation NLCoreDataFetch

+ (NSArray *)getObjects:(NSString*)entityName predicate:(NSPredicate*)predicate sortOptions:(NSArray *)sort inContext:(NSManagedObjectContext *)context
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
	if (sort != nil) {
		[fetchRequest setSortDescriptors:sort];
	}
	if (predicate != nil) {
		[fetchRequest setPredicate:predicate];
	}
    
	NSError *error = nil;
	NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
	
	if (error != nil)
	{
        NSException *exeption = [NSException exceptionWithName:@"DataBase" reason:@"Can't execute Fetch Request" userInfo:[NSDictionary dictionaryWithObject:error forKey:@"error"]];
        [exeption raise];
    }
    
    return objects;
}

+ (NSManagedObject *)getObject:(NSString*)entityName predicate:(NSPredicate*)predicate inContext:(NSManagedObjectContext *)context
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.fetchLimit = 1;
    [fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
    
	if (predicate != nil) {
		[fetchRequest setPredicate:predicate];
	}
    
	NSError *error = nil;
	NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
	
	if (error != nil)
	{
        NSException *exeption = [NSException exceptionWithName:@"DataBase" reason:@"Can't execute Fetch Request" userInfo:[NSDictionary dictionaryWithObject:error forKey:@"error"]];
        [exeption raise];
    }
    NSManagedObject *result = nil;
    if (objects != nil && [objects count] != 0) {
        result = [objects objectAtIndex:0];
    }
    return result;
}

+ (NSInteger)getObjectsCount:(NSString *)entityName inContext:(NSManagedObjectContext *)context
{    
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
    
    
	NSError *error = nil;
	NSUInteger count = [context countForFetchRequest:fetchRequest error:&error];
    
	if (error != nil)
	{
        NSException *exeption = [NSException exceptionWithName:@"DataBase" reason:@"Can't execute Fetch Request" userInfo:[NSDictionary dictionaryWithObject:error forKey:@"error"]];
        [exeption raise];
    }
    
    return count;
}

+ (NSArray *)getObjectProperties:(NSString *)entityName propertiesToFetch:(NSArray *)preperties  inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
    [fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
    [fetchRequest setResultType:NSDictionaryResultType];
    [fetchRequest setPropertiesToFetch:preperties];
    
	NSError *error = nil;
	NSArray *fetchResults = [context executeFetchRequest:fetchRequest error:&error];
    
	if (error != nil)
	{
        NSException *exeption = [NSException exceptionWithName:@"DataBase" reason:@"Can't execute Fetch Request" userInfo:[NSDictionary dictionaryWithObject:error forKey:@"error"]];
        [exeption raise];
    }
    
    return fetchResults;
}



@end
