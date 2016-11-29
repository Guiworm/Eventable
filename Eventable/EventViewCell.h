//
//  EventViewCell.h
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-28.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;

- (void)setupCell;

@end
