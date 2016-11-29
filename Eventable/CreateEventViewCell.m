//
//  CreateEventViewCell.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-28.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import "CreateEventViewCell.h"

@interface CreateEventViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *plusImage;

@end

@implementation CreateEventViewCell


-(void)setupCell{
	self.plusImage.layer.cornerRadius = 5;
}

@end
