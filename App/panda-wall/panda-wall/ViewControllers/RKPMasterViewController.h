//
//  RKPMasterViewController.h
//  panda-wall
//
//  Created by Panneerselvam, Rajkumar on 5/28/14.
//  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKPThumbnailCell.h"

@class RKPDetailViewController;

@interface RKPMasterViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) RKPDetailViewController *detailViewController;

@end
