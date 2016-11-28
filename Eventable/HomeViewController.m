//
//  ViewController.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-27.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import "HomeViewController.h"
@import Firebase;
@import FirebaseDatabase;


@interface HomeViewController ()

@property (nonatomic) FIRDatabaseReference *fireRef;

@end

@implementation HomeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    _fireRef = [[FIRDatabase database] reference];

}
-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:YES];
}


@end
