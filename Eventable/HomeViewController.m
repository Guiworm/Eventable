//
//  ViewController.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-27.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//
#import "DataManager.h"

#import "HomeViewController.h"
#import "EventDetailsViewController.h"

#import "EventViewCell.h"
#import "CreateEventViewCell.h"

#import "Event+CoreDataClass.h"
#import "Item+CoreDataClass.h"
#import "Guests+CoreDataClass.h"


@import Firebase;
@import GoogleMobileAds;
@import QuartzCore;

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet GADBannerView *adBannerView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UICollectionView *createEventsCollection;
@property (weak, nonatomic) IBOutlet UICollectionView *upcomingEventsCollection;
@property (weak, nonatomic) IBOutlet UICollectionView *pastEventsCollection;

@end

@implementation HomeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	//Firebase database creation
	self.navBar.title = @"Events";
	
	//AdMob by Google
	self.adBannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
	self.adBannerView.rootViewController = self;
	[self.adBannerView loadRequest:[GADRequest request]];
	
//    Event *event = [NSEntityDescription
//                 insertNewObjectForEntityForName:@"Event"
//                 inManagedObjectContext:[DataManager sharedInstance].context];
//
//
//    event.title = @"Nap Time";
//    NSTimeInterval MY_EXTRA_TIME = 36000;
//    event.date = [[NSDate date] dateByAddingTimeInterval:MY_EXTRA_TIME];
//    event.location = @"Montreal";

//    Item *item = [NSEntityDescription
//                    insertNewObjectForEntityForName:@"Item"
//                    inManagedObjectContext:[DataManager sharedInstance].context];
//    item.name = @"Beer";
//    item.photoName = @"beer.png";
//    item.quantity = 12;
//    
//    [[DataManager sharedInstance] saveContext];
	
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewWillAppear: animated];
	[self.createEventsCollection reloadData];
	[self.upcomingEventsCollection reloadData];
	[self.pastEventsCollection reloadData];
}




#pragma Collections View

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSDate *now = [NSDate new];
    
    NSMutableArray *createdArray = [NSMutableArray new];
    NSMutableArray *upcomingArray = [NSMutableArray new];
    NSMutableArray *pastArray = [NSMutableArray new];
    
    for (Event *event in [[DataManager sharedInstance] fetchData:@"Event"]) {
        if([event.date compare: now] == NSOrderedAscending){
            [pastArray addObject:event];
        } else if([event.date compare: now] == NSOrderedDescending){
            [upcomingArray addObject:event];
        } else {
            [createdArray addObject:event];
        }
    }
    
	if(collectionView == self.createEventsCollection){
		return createdArray.count + 1;
	}
	else if (collectionView == self.upcomingEventsCollection){
		return upcomingArray.count;
	}
	else if (collectionView == self.pastEventsCollection){
		return pastArray.count;
	}
	
    return -1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger totalCells = [self collectionView:collectionView numberOfItemsInSection:indexPath.section];
	
	//Configure Final Cell in the section to be an "Add New Event" cell but
	//Only on the create collection
	if(collectionView == self.createEventsCollection){
        if((indexPath.row == totalCells-1) || (indexPath.row == 0)){
            CreateEventViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"createEventCell" forIndexPath:indexPath];
            [cell setupCell];
            return cell;
        }
	}
	
	// Configure all other cells filled with events
    EventViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"eventCell" forIndexPath:indexPath];
    [cell setupCell];
    
    NSArray *array = [[DataManager sharedInstance] fetchData:@"Event"];
    Event *event = array[indexPath.row];
    cell.eventName.text = event.title;
    return cell;
}

//Send cell to the next view controller to determine if it needs to create a new event or not
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	[self performSegueWithIdentifier:@"showEventDetails" sender:[collectionView cellForItemAtIndexPath:indexPath]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	EventDetailsViewController *vc = (EventDetailsViewController*) segue.destinationViewController;
	vc.myEventCell = sender;
	
}

@end
