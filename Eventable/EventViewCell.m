//
//  EventViewCell.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-28.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import "EventViewCell.h"

@interface EventViewCell ()

@end

@implementation EventViewCell

- (void)setupCell:(Event*)event{
	self.eventImage.layer.cornerRadius = 5;
    self.eventImage.image = [UIImage imageNamed:[NSString stringWithFormat: @"EventBackground1.png"]];//, arc4random_uniform(4)+1]];
    self.eventName.text = event.title;
	self.eventName.textColor = [UIColor whiteColor];
}


@end
