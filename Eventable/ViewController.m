//
//  ViewController.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-27.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import "ViewController.h"
@import Firebase;
@import FirebaseDatabase;


@interface ViewController ()

@property (nonatomic) FIRDatabaseReference *ref;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    _ref = [[FIRDatabase database] reference];

}


@end
