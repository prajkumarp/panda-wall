//
//  RKPDetailViewController.h
//  panda-wall
//
//  Created by Panneerselvam, Rajkumar on 5/28/14.
//  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKPDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (nonatomic, strong) UIImage *passonImage;
@property (nonatomic, strong) IBOutlet UIImageView *fullSizeImage;
@property (nonatomic, strong) IBOutlet UILabel *imageTimeStamp;
@property (nonatomic, strong) IBOutlet UILabel *imageGeoTag;

@end
