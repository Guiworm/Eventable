//
//  CreateItemViewController.h
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-29.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Event;
#import "EventDetailsViewController.h"


@interface CreateItemViewController : UIViewController 

@property (nonatomic) Event *itemEvent;
@property id<DismissCreateItem> delegate;

@end
