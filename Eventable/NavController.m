//
//  NavController.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-27.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import "NavController.h"

@interface NavController ()

@end

@implementation NavController

- (void)viewDidLoad {
    [super viewDidLoad];
	
//	[self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
	[self.navigationBar setBarTintColor: [UIColor colorWithRed:0.5f green:0.0f blue:0.0f alpha:1.0f]];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
