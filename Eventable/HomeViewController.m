//
//  ViewController.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-27.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import "HomeViewController.h"
#import "EventDetailsViewController.h"

#import "EventViewCell.h"
#import "CreateEventViewCell.h"

@import Firebase;
@import FirebaseDatabase;
@import GoogleMobileAds;
@import QuartzCore;

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet GADBannerView *adBannerView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UICollectionView *createEventsCollection;
@property (weak, nonatomic) IBOutlet UICollectionView *upcomingEventsCollection;
@property (weak, nonatomic) IBOutlet UICollectionView *pastEventsCollection;
@property (nonatomic) FIRDatabaseReference *fireRef;

@end

@implementation HomeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	//Firebase database creation
    _fireRef = [[FIRDatabase database] reference];
	self.navBar.title = @"Events";
	
	//AdMob by Google
	self.adBannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
	self.adBannerView.rootViewController = self;
	[self.adBannerView loadRequest:[GADRequest request]];
	
	
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewWillAppear: animated];
}




#pragma Collections View

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	if(collectionView == self.createEventsCollection){
		return 3;
	}
	else if (collectionView == self.upcomingEventsCollection){
		return 6;
	}
	else if (collectionView == self.pastEventsCollection){
		return 4;
	}
	
	return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger totalCells = [self collectionView:collectionView numberOfItemsInSection:indexPath.section];
	
	//Configure Final Cell in the section to be an "Add New Event" cell but
	//Only on the create collection
	if((collectionView == self.createEventsCollection) && (indexPath.row == totalCells-1)){
		CreateEventViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"createEventCell" forIndexPath:indexPath];
		[cell setupCell];
		return cell;
	}
	
	// Configure all other cells filled with events
	else{
		EventViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"eventCell" forIndexPath:indexPath];
		[cell setupCell];
		return cell;
	}
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
