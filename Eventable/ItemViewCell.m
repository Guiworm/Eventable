//
//  ItemViewCell.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-28.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import "ItemViewCell.h"

@implementation ItemViewCell

- (void) setupCell{
	self.itemImage.layer.cornerRadius = 5;
	self.itemImage.image = [UIImage imageNamed:[NSString stringWithFormat: @"EventBackground%u.png", arc4random_uniform(4)+1]];
	self.itemName.text = @"New Item";
//	self.itemName.layer.cornerRadius = 5;
	self.itemName.textColor = [UIColor whiteColor];
}


@end
