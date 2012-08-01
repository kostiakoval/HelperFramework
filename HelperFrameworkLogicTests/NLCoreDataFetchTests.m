//
//  NLCoreDataFetchTests.m
//  NLCoreDataFetchTests
//
//  Created by Konstantin on 7/31/12.
//  Copyright (c) 2012 nLink. All rights reserved.
//
#import <CoreData/CoreData.h>
#import "NLCoreDataFetchTests.h"
#import "NLCoreDataContextManager.h"
#import "NLCoreDataFetch.h"
#import "TestEntity.h"

static NSString *entityName = @"TestEntity";
static NSUInteger ObjectsCount = 2;

@implementation NLCoreDataFetchTests

- (void)setUp
{
    [super setUp];
    
    m_contextManager = [[NLCoreDataContextManager alloc] init];
    NSManagedObjectContext *context = m_contextManager.mainManagedObjectContext;
    for (int i = 0; i < ObjectsCount; ++i) {
        TestEntity *testObject = (TestEntity*) [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
        testObject.index = [NSNumber numberWithInt:i];
        testObject.name = [NSString stringWithFormat:@"%d", i];
    }
}

- (void)tearDown
{
    // Tear-down code here.
    m_contextManager = nil;
    
    [super tearDown];
}

- (void)testGetAllObjects
{
    NSArray *objects = [NLCoreDataFetch getObjects:entityName predicate:nil sortOptions:nil inContext:m_contextManager.mainManagedObjectContext];
    STAssertNotNil(objects, @"mut be not nil");
    STAssertEquals([objects count], ObjectsCount, @"Fetched count %d doesn't equal real count :%d", [objects count], ObjectsCount);
}

- (void)testGetAllObjectsSorted
{
    NSArray *sort = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES]];
    NSArray *objects = [NLCoreDataFetch getObjects:entityName predicate:nil sortOptions:sort inContext:m_contextManager.mainManagedObjectContext];
    STAssertNotNil(objects, @"mut be not nil");
    
}

@end
