//
//  AppDelegate.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-27.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import "AppDelegate.h"
#import "DataManager.h"


#import "Event+CoreDataClass.h"
#import "Item+CoreDataClass.h"
#import "Guests+CoreDataClass.h"




@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[DataManager sharedInstance] saveContext];
}

//- (void)createDummyEventsWithItems {
//    // create 5 events
//    Event *e1 = [NSEntityDescription
//                                           insertNewObjectForEntityForName:@"Event"
//                                           inManagedObjectContext:self.manager.context];
//    
//    // create 5 items per event
//    Item *i1a = [NSEntityDescription
//                 insertNewObjectForEntityForName:@"Item"
//                 inManagedObjectContext:self.manager.context];
//    i1a.name = @"afasfda";
//    i1a.quantity = 10;
//    
//    
//    [self.manager saveContext];
//    
//    
//    
//}

- (NSArray *)fetchAllEvents {
    return nil;
}


@end
