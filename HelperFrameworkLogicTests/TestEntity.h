//
//  TestEntity.h
//  HelperFramework
//
//  Created by Konstantin on 8/1/12.
//  Copyright (c) 2012 nLink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TestEntity : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * index;

@end
