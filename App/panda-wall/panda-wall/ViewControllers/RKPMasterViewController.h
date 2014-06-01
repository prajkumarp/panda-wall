//
//  RKPMasterViewController.h
//  panda-wall
//
//  Created by Panneerselvam, Rajkumar on 5/28/14.
//  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKPThumbnailCell.h"
#import "MediaManager/MediaManager.h"


@class RKPDetailViewController;

@interface RKPMasterViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate,UIAlertViewDelegate>{
    
    NSArray *imageCollection;
}

@property (strong, nonatomic) RKPDetailViewController *detailViewController;

@end
