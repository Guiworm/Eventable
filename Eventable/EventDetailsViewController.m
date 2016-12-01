//
//  EventDetailsViewController.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-28.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//
#import "DataManager.h"
#import "EventDetailsViewController.h"
#import "ItemViewCell.h"
#import "CreateItemViewCell.h"
#import "ItemSectionHeaderView.h"
#import "Item+CoreDataClass.h"
#import "CreateEventViewCell.h"

@interface EventDetailsViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation EventDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
	if([self.myEventCell isMemberOfClass:[CreateEventViewCell class]]){
		[self performSegueWithIdentifier:@"createNewEvent" sender:nil];
	}
	[self.collectionView reloadData];
}

#pragma Collection View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"items.have == TRUE"];
    
    NSArray *array = [[DataManager sharedInstance] fetchData:@"Event" withPredicate:predicate];
	
    NSLog(@"Count: %@", array);

	return array.count+1;
	
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger totalCells = [self collectionView:collectionView numberOfItemsInSection:indexPath.section];
	
	// Configure all other cells filled with items already
	if(indexPath.row != totalCells-1){
		ItemViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemCell" forIndexPath:indexPath];
		[cell setupCell];
		
		NSArray *array = [[DataManager sharedInstance] fetchData:@"Item"];
		Item *item = array[indexPath.row];
		cell.itemName.text = item.name;
		
		[[DataManager sharedInstance] saveContext];
		
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
		[self performSegueWithIdentifier:@"addItem" sender:nil];
	}
	
	if([[collectionView cellForItemAtIndexPath:indexPath] isMemberOfClass:[ItemViewCell class]]){
		[self performSegueWithIdentifier:@"itemDetails" sender:nil];
	}
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









