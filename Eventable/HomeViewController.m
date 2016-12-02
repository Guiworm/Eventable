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
#import "CreateEventViewController.h"

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
@property (nonatomic) NSMutableArray *createdArray;
@property (nonatomic) NSMutableArray *pastArray;
@property (nonatomic) NSMutableArray *upcomingArray;
@property (nonatomic) NSArray *fetchedArray;


@end

@implementation HomeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	//Firebase database creation
	self.title = @"Events";
	
	//AdMob by Google
	self.adBannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
	self.adBannerView.rootViewController = self;
	[self.adBannerView loadRequest:[GADRequest request]];
}

-(void)viewDidAppear:(BOOL)animated{
    
    self.fetchedArray = [[DataManager sharedInstance] fetchData:@"Event"];
    [self sortArray];
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
    
	if(collectionView == self.createEventsCollection){
		return self.createdArray.count + 1;
	}
	else if (collectionView == self.upcomingEventsCollection){
		return self.upcomingArray.count;
	}
	else if (collectionView == self.pastEventsCollection){
		return self.pastArray.count;
	}
	
    return -1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	
    
    NSInteger totalCells = [self collectionView:collectionView numberOfItemsInSection:indexPath.section];
	
	//Configure Final Cell in the section to be an "Add New Event" cell but
	//Only on the create collection
	if(collectionView == self.createEventsCollection){
        if((indexPath.row == totalCells-1)){
            CreateEventViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"createEventCell" forIndexPath:indexPath];
            [cell setupCell];
            return cell;
        }
    } else if (collectionView == self.upcomingEventsCollection){
        
        // Configure all other cells filled with events
        EventViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"eventCell" forIndexPath:indexPath];
        
        Event *event = self.upcomingArray[indexPath.row];
        NSLog(@"Section: %@  Row: %ld",collectionView, indexPath.row);
//        cell.eventName.text = event.title;
        [cell setupCell:event];
        return cell;
        
    }else if (collectionView == self.pastEventsCollection){
        // Configure all other cells filled with events
        EventViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"eventCell" forIndexPath:indexPath];
        
        Event *event = self.pastArray[indexPath.row];
        NSLog(@"Section: %@  Row: %ld",collectionView, indexPath.row);
        //    cell.eventName.text = event.title;
        
        [cell setupCell:event];
        
        return cell;
    }
	
    return nil;
}

//Send cell to the next view controller to determine if it needs to create a new event or not
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	if(collectionView == self.createEventsCollection){
		[self performSegueWithIdentifier:@"createEvent" sender:[collectionView cellForItemAtIndexPath:indexPath]];
	}
	else if(collectionView == self.upcomingEventsCollection){
		Event *event = self.upcomingArray[indexPath.row];
		[self performSegueWithIdentifier:@"showEventDetails" sender:event];
	}
	else if(collectionView == self.pastEventsCollection){
		Event *event = self.pastArray[indexPath.row];
		[self performSegueWithIdentifier:@"showEventDetails" sender:event];
	}

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	
	if([segue.identifier isEqualToString:@"showEventDetails"]){
		EventDetailsViewController *vc = (EventDetailsViewController*) segue.destinationViewController;
		vc.event = sender;
	}
	else if ([segue.identifier isEqualToString:@"createEvent"]){
		CreateEventViewController *vc = (CreateEventViewController *) segue.destinationViewController;
		vc.delegate = self;
	}
}


-(void)sortArray {
    
    self.createdArray = [NSMutableArray new];
    self.upcomingArray = [NSMutableArray new];
    self.pastArray = [NSMutableArray new];
    
    NSDate *now = [NSDate new];

    for (Event *event in self.fetchedArray) {
        if([event.date compare: now] == NSOrderedAscending){
            [self.pastArray addObject:event];
        } else if([event.date compare: now] == NSOrderedDescending){
            [self.upcomingArray addObject:event];
        } else {
            [self.createdArray addObject:event];
        }
    }
}

- (void)reloadCollectionViews{
	self.fetchedArray = [[DataManager sharedInstance] fetchData:@"Event"];
	[self sortArray];
	[self.createEventsCollection reloadData];
	[self.upcomingEventsCollection reloadData];
	[self.pastEventsCollection reloadData];
}


- (IBAction)deleteEventGesture:(UILongPressGestureRecognizer *)sender {
	CGPoint point = [sender locationInView:self.upcomingEventsCollection];
	NSIndexPath *indexPath = [self.upcomingEventsCollection indexPathForItemAtPoint:point];
	
	UICollectionViewCell* cell = [self.upcomingEventsCollection cellForItemAtIndexPath:indexPath];

	if (sender.state == UIGestureRecognizerStateBegan) {
		[cell.layer addAnimation:[self shakeAnimation] forKey:@""];
	}
	
	if(sender.state == UIGestureRecognizerStateChanged){
		[cell.layer removeAllAnimations];
	}
	
	if (sender.state != UIGestureRecognizerStateEnded) {
		return;
	}
	
	if (indexPath == nil){
		NSLog(@"couldn't find index path");
	} else {
		// get the cell at indexPath (the one you long pressed)
		//UICollectionViewCell* cell = [self.upcomingEventsCollection cellForItemAtIndexPath:indexPath];
		cell.layer.borderWidth = 0;
		[[DataManager sharedInstance].context deleteObject: self.upcomingArray[indexPath.row]];
		[[DataManager sharedInstance] saveContext];
		[self.upcomingEventsCollection performBatchUpdates:^ {
			[self.upcomingArray removeObjectAtIndex:indexPath.row];
			[self.upcomingEventsCollection deleteItemsAtIndexPaths:@[indexPath]];
		} completion:nil];
	}
}

- (IBAction)deletePastEventGesture:(UILongPressGestureRecognizer *)sender {
	CGPoint point = [sender locationInView:self.pastEventsCollection];
	NSIndexPath *indexPath = [self.pastEventsCollection indexPathForItemAtPoint:point];
	UICollectionViewCell* cell = [self.pastEventsCollection cellForItemAtIndexPath:indexPath];
	
	if (sender.state == UIGestureRecognizerStateBegan) {
		[cell.layer addAnimation:[self shakeAnimation] forKey:@""];
	}
	
	if(sender.state == UIGestureRecognizerStateChanged){
		[cell.layer removeAllAnimations];
	}
	
	if (sender.state != UIGestureRecognizerStateEnded) {
		return;
	}
	
	if (indexPath == nil){
		NSLog(@"couldn't find index path");
	} else {
		// get the cell at indexPath (the one you long pressed)
		//UICollectionViewCell* cell = [self.upcomingEventsCollection cellForItemAtIndexPath:indexPath];
		cell.layer.borderWidth = 0;
		[[DataManager sharedInstance].context deleteObject: self.pastArray[indexPath.row]];
		[[DataManager sharedInstance] saveContext];
		[self.upcomingEventsCollection performBatchUpdates:^ {
			[self.pastArray removeObjectAtIndex:indexPath.row];
			[self.pastEventsCollection deleteItemsAtIndexPaths:@[indexPath]];
		} completion:nil];
	}
}

#pragma Animations
- (CAAnimation*)shakeAnimation{
	CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	CGFloat wobbleAngle = 0.06f;
	
	NSValue* shakeLeft = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(wobbleAngle, 0.0f, 0.0f, 1.0f)];
	NSValue* shakeRight = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-wobbleAngle, 0.0f, 0.0f, 1.0f)];
	animation.values = [NSArray arrayWithObjects:shakeLeft, shakeRight, nil];
	animation.autoreverses = YES;
	animation.duration = 0.125;
	animation.repeatCount = HUGE_VALF;
	
	return animation;
}

@end
