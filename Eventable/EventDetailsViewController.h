//
//  EventDetailsViewController.h
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-28.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Event;

@protocol DismissCreateItem <NSObject>

-(void) reloadItemCollection;
@end

@interface EventDetailsViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, DismissCreateItem>

@property (nonatomic) UICollectionViewCell *myEventCell;
@property (nonatomic) Event *event;

@end
