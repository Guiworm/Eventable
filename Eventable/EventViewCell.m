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

- (void)setupCell{
	self.eventImage.layer.cornerRadius = 5;
	self.eventImage.image = [UIImage imageNamed:@"EventBackground.png"];
	self.eventName.text = @"New Event";
	self.eventName.textColor = [UIColor whiteColor];
}


@end
