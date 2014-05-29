//
//  ImageInformation.h
//  MediaManager
//
//  Created by Panneerselvam, Rajkumar on 5/29/14.
//  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ImageInformation : NSObject

@property (strong) NSString *imagePath;
@property (strong) CLLocation *geoTag;
@property (strong) NSDate *timeStamp;

- (NSString *)getDateandTime;

@end
