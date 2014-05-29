//
//  RKPThumbnailCell.h
//  panda-wall
//
//  Created by Panneerselvam, Rajkumar on 5/28/14.
//  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaManager/ImageInformation.h"

@interface RKPThumbnailCell : UICollectionViewCell

@property (strong) IBOutlet UIImageView *thumbnailImage;
@property (strong)  ImageInformation *imageDetails;

@end
