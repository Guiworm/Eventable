//
//  ViewController.h
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-27.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DismissCreateEvent <NSObject>
- (void)reloadCollectionViews;
@end

@interface HomeViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, DismissCreateEvent>


@end

