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

@end

@implementation ItemDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.popupView.layer.cornerRadius = 10;
}

- (IBAction)dismissViewTap:(UITapGestureRecognizer *)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
