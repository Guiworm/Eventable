//
//  CreateItemViewCell.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-28.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import "CreateItemViewCell.h"

@interface CreateItemViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *plusImage;

@end

@implementation CreateItemViewCell

-(void)setupCell{
	self.plusImage.layer.cornerRadius = 5;
}

@end
