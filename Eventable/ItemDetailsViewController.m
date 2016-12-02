//
//  ItemDetailsViewController.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-29.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import "ItemDetailsViewController.h"

@interface ItemDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIView *popupView;
@property (strong, nonatomic) IBOutlet UILabel *howManyLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *itemNameLabel;

@end

@implementation ItemDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.popupView.layer.cornerRadius = 10;
    
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat: @"EventBackground1.png"]];
    self.howManyLabel.text = [NSString stringWithFormat:@"%d", self.myitem.quantity];
    self.itemNameLabel.text = self.myitem.name;
}

- (IBAction)dismissViewTap:(UITapGestureRecognizer *)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
