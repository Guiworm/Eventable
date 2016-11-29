//
//  ViewController.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-27.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import "HomeViewController.h"
#import "EventViewCell.h"
#import "CreateEventViewCell.h"

@import Firebase;
@import FirebaseDatabase;


@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UICollectionView *createEventsCollection;
@property (weak, nonatomic) IBOutlet UICollectionView *upcomingEventsCollection;
@property (weak, nonatomic) IBOutlet UICollectionView *pastEventsCollection;
@property (nonatomic) FIRDatabaseReference *fireRef;

@end

@implementation HomeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    _fireRef = [[FIRDatabase database] reference];
	self.navBar.title = @"Events";
}
-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:YES];
}


#pragma Collections View

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return 7;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger totalCells = [self collectionView:collectionView numberOfItemsInSection:indexPath.section];
	
	// Configure all cells filled with events
	if(indexPath.row != totalCells-1){
		EventViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"eventCell" forIndexPath:indexPath];
		[cell setupCell];
		return cell;
	}
	
	//Configure Final Cell in the section to be an "Add New Event" cell
	else{
		CreateEventViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"createEventCell" forIndexPath:indexPath];
		[cell setupCell];
		return cell;
	}
}


@end
