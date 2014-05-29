//
//  MediaManager.m
//  MediaManager
//
//  Created by Panneerselvam, Rajkumar on 5/28/14.
//  Copyright (c) 2014 Panneerselvam, Rajkumar. All rights reserved.
//

#import "MediaManager.h"
#import "ImageInformation.h"

@implementation MediaManager

+(void) myMethod:(myCompletion) compblock{
    
    NSMutableArray *returnImageList = [[NSMutableArray alloc] init];
    
    ImageInformation *tempImageInfo = [[ImageInformation alloc] init];
    
    [tempImageInfo setImagePath:@"vcard"];
    [tempImageInfo setTimeStamp:[[NSDate alloc] init]];
    [tempImageInfo setGeoTag:[[CLLocation alloc] initWithLatitude:20.0060893 longitude:-102.7813159]];
    
    [returnImageList addObject:tempImageInfo];
    
    compblock(returnImageList);
}


@end
