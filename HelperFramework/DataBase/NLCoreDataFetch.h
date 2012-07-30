//
//  NLCoreDataFetch.h
//  HelperFramework
//
//  Created by Konstantin on 7/30/12.
//  Copyright (c) 2012 nLink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NLCoreDataFetch : NSObject

+ (NSArray *)getObjects:(NSString*)entityName predicate:(NSPredicate*)predicate sortOptions:(NSArray *)sort inContext:(NSManagedObjectContext *)context;
+ (NSManagedObject *)getObject:(NSString*)entityName predicate:(NSPredicate*)predicate inContext:(NSManagedObjectContext *)context;

+ (NSInteger)getObjectsCount:(NSString *)entityName inContext:(NSManagedObjectContext *)context;
+ (NSArray *)getObjectProperties:(NSString *)entityName propertiesToFetch:(NSArray *)preperties  inContext:(NSManagedObjectContext *)context;



@end
