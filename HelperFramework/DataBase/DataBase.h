//
//  DataBase.h
//  GymTracker
//
//  Created by Konstantin on 5/7/12.
//  Copyright (c) 2012 nLink.no. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataBase : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *mainManagedObjectContext;

- (NSManagedObjectContext *)newLocalContext;
- (void)saveContext:(NSManagedObjectContext*)context;
@end
