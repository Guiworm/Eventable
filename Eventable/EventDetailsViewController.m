//
//  EventDetailsViewController.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-28.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//
#import "DataManager.h"
#import "EventDetailsViewController.h"
#import "CreateItemViewController.h"

#import "ItemViewCell.h"
#import "CreateItemViewCell.h"
#import "CreateEventViewCell.h"
#import "ItemSectionHeaderView.h"

#import "Item+CoreDataClass.h"
#import "Event+CoreDataClass.h"


@interface EventDetailsViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (nonatomic) NSMutableArray *haveItems;
@property (nonatomic) NSMutableArray *haveNotItems;


@end

@implementation EventDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self recheckData];
}

- (void) recheckData{
	self.haveItems = [NSMutableArray new];
	self.haveNotItems = [NSMutableArray new];
	
	
	for (Item *item in self.event.items) {
		if (item.have) {
			[self.haveItems addObject: item];
		}
		else if(!item.have){
			[self.haveNotItems addObject: item];
		}
	}
}

-(void)viewDidAppear:(BOOL)animated{
	[self.collectionView reloadData];
}

#pragma Collection View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	
//	NSPredicate *predicate;
//	
//	if(section == 0){
//		predicate = [NSPredicate predicateWithFormat:@"items.have == TRUE"];
//	}
//	else{
//		predicate = [NSPredicate predicateWithFormat:@"items.have == FALSE"];
//	}
	
	
	

	if(section == 0){
		return self.haveItems.count+1;
	}
	else{
		return self.haveNotItems.count+1;

	}
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger totalCells = [self collectionView:collectionView numberOfItemsInSection:indexPath.section];
	
	// Configure all other cells filled with items already
	if(indexPath.row != totalCells-1){
		ItemViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemCell" forIndexPath:indexPath];
		[cell setupCell];
		
		Item *item;
		
		if(indexPath.section == 0){
			item = self.haveItems[indexPath.row];
		}
		else{
			item = self.haveNotItems[indexPath.row];
		}
		
		
		cell.itemName.text = item.name;
		
		
		
		//Making the label rounded on top only
		CAShapeLayer * maskLayer = [CAShapeLayer layer];
		maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: cell.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){5.0, 5.0}].CGPath;
		//Applying the mask
		cell.layer.mask = maskLayer;
		
		return cell;
	}
	//Make the last cell a plus to add new item
	else{
		CreateItemViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"createItemCell" forIndexPath:indexPath];
		[cell setupCell];
		return cell;
	}
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	
	if([[collectionView cellForItemAtIndexPath:indexPath] isMemberOfClass:[CreateItemViewCell class]]){
		[self performSegueWithIdentifier:@"addItem" sender:self.event];
	}
	
	if([[collectionView cellForItemAtIndexPath:indexPath] isMemberOfClass:[ItemViewCell class]]){
		[self performSegueWithIdentifier:@"itemDetails" sender:nil];
	}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if([segue.identifier isEqualToString:@"addItem"]){
		CreateItemViewController *vc = (CreateItemViewController *) segue.destinationViewController;
		vc.itemEvent = sender;
		vc.delegate = self;
	}
}

-(void) reloadItemCollection{
	[self recheckData];
	[self.collectionView reloadData];
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
	
	//Name the sections on the event page
	NSString *title;
	if (indexPath.section == 0) {
		title = [NSString stringWithFormat:@"WHAT WE HAVE"];
	}
	else{
		title = [NSString stringWithFormat:@"WHAT WE NEED"];

	}
	
	ItemSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"eventHeader" forIndexPath:indexPath];
	headerView.sectionTitleLabel.text = title;
	headerView.sectionTitleLabel.textColor = [UIColor whiteColor];
	
	return headerView;
}

@end









