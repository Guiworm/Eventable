//
//  DataManager.h
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-30.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface DataManager : NSObject

+ (DataManager*)sharedInstance;
- (NSArray *) fetchData:(NSString *)name;
- (void)saveContext;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@end
