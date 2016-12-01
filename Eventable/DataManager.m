//
//  DataManager.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-30.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//



#import "DataManager.h"

@implementation DataManager

//Singleton
+ (DataManager *)sharedInstance
{
	static DataManager *_instance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_instance = [[DataManager alloc] init];
	});
	return _instance;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
	// The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
	@synchronized (self) {
		if (_persistentContainer == nil) {
			_persistentContainer = [[NSPersistentContainer alloc] initWithName:@"EventModel"];
			[_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
				if (error != nil) {
					// Replace this implementation with code to handle the error appropriately.
					// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
					
					/*
					 Typical reasons for an error here include:
					 * The parent directory does not exist, cannot be created, or disallows writing.
					 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
					 * The device is out of space.
					 * The store could not be migrated to the current model version.
					 Check the error message to determine what the actual problem was.
					 */
					NSLog(@"Unresolved error %@, %@", error, error.userInfo);
					abort();
				}
			}];
		}
	}
	
	return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
	NSManagedObjectContext *context = self.persistentContainer.viewContext;
	NSError *error = nil;
	if ([context hasChanges] && ![context save:&error]) {
		// Replace this implementation with code to handle the error appropriately.
		// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		NSLog(@"Unresolved error %@, %@", error, error.userInfo);
		abort();
	}
}


#pragma GetDataObjects
//Fetch all the data attatched to an entity and hand it back as an array
-(NSArray *) fetchData:(NSString *)name{
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:name
											  inManagedObjectContext:self.persistentContainer.viewContext];
	[fetchRequest setEntity:entity];
	
	NSError *error;
	NSArray *fetchedObjects = [self.persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];
	
	return fetchedObjects;
}

- (NSManagedObjectContext *)context {
    return self.persistentContainer.viewContext;
}

-(NSArray *) fetchData:(NSString *)name withPredicate:(NSPredicate*)predicate{

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:name
                                              inManagedObjectContext:self.persistentContainer.viewContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [self.persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];
    
    fetchedObjects = [fetchedObjects filteredArrayUsingPredicate:predicate];
    
    return fetchedObjects;



}


@end
