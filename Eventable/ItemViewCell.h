//
//  ItemViewCell.h
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-28.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;


- (void) setupCell;
@end
